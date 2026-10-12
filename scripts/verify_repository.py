"""Check source-skill packaging; this does not prove literary or client quality.

Run with Python 3.11+: python -X utf8 scripts/verify_repository.py --self-test
"""
import argparse
import json
import re
import sys
import tomllib
from pathlib import Path
from urllib.parse import unquote, urlsplit

SKILLS = {
    'zima-scroll-rod-and-chapter-outline': 'zima-scroll-rod-and-chapter-outline',
    'zima-write-web story': 'zima-write-web-story',
}
ROLES = ('content-writer', 'polisher', 'outline-checker')


def frontmatter(text):
    match = re.match(r'\A---\r?\n(.*?)\r?\n---(?:\r?\n|$)', text, re.S)
    if not match:
        raise ValueError('missing frontmatter')
    values = {}
    for line in match[1].splitlines():
        if not line.strip() or line.lstrip().startswith('#'):
            continue
        if ':' not in line:
            raise ValueError('unsupported frontmatter line: ' + line)
        key, value = line.split(':', 1)
        if key in values:
            raise ValueError('duplicate frontmatter key: ' + key)
        values[key] = value.strip().strip('"').strip("'")
    return values


def check_evals(data, directory):
    errors = []
    ids = set()
    cases = data.get('evals', [])
    if not isinstance(cases, list) or not cases:
        return ['evals must be a nonempty list']
    for case in cases:
        number = case.get('id')
        if not isinstance(number, int) or number in ids:
            errors.append('missing or duplicate integer eval id')
        ids.add(number)
        for key in ('prompt', 'expected_output'):
            if not isinstance(case.get(key), str) or not case[key].strip():
                errors.append(f'eval {number}: missing {key}')
        assertions = case.get('assertions')
        if not isinstance(assertions, list) or not assertions or not all(isinstance(x, str) and x.strip() for x in assertions):
            errors.append(f'eval {number}: assertions must be nonempty strings')
        files = case.get('files')
        if not isinstance(files, list):
            errors.append(f'eval {number}: files must be a list')
        else:
            for filename in files:
                if not isinstance(filename, str) or not (directory / filename).is_file():
                    errors.append(f'eval {number}: missing fixture {filename}')
    return errors


def check_links(path, text):
    errors = []
    count = 0
    for match in re.finditer(r'\[[^\]\n]*\]\(([^)\n]+)\)', text):
        target = match[1].strip()
        if target.startswith('<') and target.endswith('>'):
            target = target[1:-1]
        parts = urlsplit(target)
        if parts.scheme or target.startswith('#'):
            continue
        file_part = unquote(parts.path)
        if file_part:
            count += 1
            if not (path.parent / file_part).is_file():
                errors.append(f'{path.name}: broken local link {target}')
    return errors, count


def self_test(root):
    valid = {'evals': [dict(id=1, prompt='p', expected_output='e', assertions=['a'], files=[])]}
    assert not check_evals(valid, root)
    duplicate = {'evals': valid['evals'] * 2}
    assert check_evals(duplicate, root)
    missing_fixture = {'evals': [dict(valid['evals'][0], files=['missing-fixture-for-negative-check.md'])]}
    assert check_evals(missing_fixture, root)
    assert check_links(root / 'probe.md', '[broken](missing-link-for-negative-check.md)')[0]
    assert not check_links(root / 'probe.md', '[remote](https://example.com)')[0]
    for parser, source in ((json.loads, '{'), (tomllib.loads, 'x = ['), (frontmatter, 'missing')):
        try:
            parser(source)
        except ValueError:
            pass
        else:
            raise AssertionError('invalid input accepted')
    return 8


def verify(root):
    errors, counts = [], dict(skills=0, evals=0, fixtures=0, templates=0, matching_role_bodies=0, local_references=0, utf8_files=0)
    paths = [p for name in SKILLS for p in (root / name).rglob('*') if p.is_file()]
    paths.extend([root / 'README.md', *list((root / 'docs').glob('*.md'))])
    for path in paths:
        if path.suffix in ('.md', '.mdc', '.json', '.toml', '.py', '.ps1') or path.name == 'LICENSE':
            try:
                text = path.read_text(encoding='utf-8-sig')
                counts['utf8_files'] += 1
                if '\ufffd' in text:
                    errors.append(f'{path}: Unicode replacement character found')
                if path.suffix in ('.md', '.mdc'):
                    found, count = check_links(path, text)
                    errors.extend(found)
                    counts['local_references'] += count
            except (UnicodeError, ValueError) as exc:
                errors.append(f'{path}: {exc}')
    for folder, name in SKILLS.items():
        skill = root / folder
        try:
            entry = (skill / 'SKILL.md').read_text(encoding='utf-8-sig')
            fm = frontmatter(entry)
            if fm.get('name') != name or not fm.get('description'):
                errors.append(f'{folder}: name/description invalid')
            counts['skills'] += 1
            for doc in [skill / 'SKILL.md', *list((skill / 'references').glob('*.md'))]:
                for target in re.findall(r'`((?:references|templates|scripts|evals)/[^`\n]+\.(?:md|mdc|toml|json|py|ps1))`', doc.read_text(encoding='utf-8-sig')):
                    counts['local_references'] += 1
                    if not (skill / target).is_file():
                        errors.append(f'{doc.name}: missing skill resource {target}')
            evaluation = json.loads((skill / 'evals/evals.json').read_text(encoding='utf-8-sig'))
            if evaluation.get('skill_name') != name:
                errors.append(f'{folder}: eval skill name mismatch')
            errors.extend(check_evals(evaluation, skill / 'evals'))
            counts['evals'] += len(evaluation['evals'])
            counts['fixtures'] += len(list((skill / 'evals/fixtures').glob('*')))
        except (OSError, ValueError, KeyError) as exc:
            errors.append(f'{folder}: {exc}')
    base = root / 'zima-write-web story/templates'
    for role in ROLES:
        bodies = []
        for client, directory, extension in (('codex', 'agents', 'toml'), ('claude', 'agents', 'md'), ('cursor', 'rules', 'mdc')):
            filename = f'zima-{role}' if client == 'cursor' else role
            path = base / client / directory / f'{filename}.{extension}'
            try:
                content = path.read_text(encoding='utf-8-sig')
                data = tomllib.loads(content) if extension == 'toml' else frontmatter(content)
                if not data:
                    raise ValueError('empty template metadata')
                body = data.get('developer_instructions', '') if extension == 'toml' else content
                marker = '## 入口、路径与证据'
                if marker not in body:
                    raise ValueError('missing shared role contract section')
                bodies.append(body[body.index(marker):].strip())
                counts['templates'] += 1
            except (OSError, ValueError) as exc:
                errors.append(f'{path}: {exc}')
        if len(bodies) == 3 and len(set(bodies)) == 1:
            counts['matching_role_bodies'] += 1
        else:
            errors.append(f'{role}: role contracts differ across clients')
    return dict(status='pass' if not errors else 'fail', counts=counts, errors=errors,
                scope='Source packaging only. Behavioral cases and actual client loading require separate evidence.')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--root', type=Path, default=Path(__file__).resolve().parents[1])
    parser.add_argument('--self-test', action='store_true')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = verify(args.root.resolve())
    if args.self_test:
        result['validator_self_tests'] = self_test(args.root.resolve())
    encoded = json.dumps(result, ensure_ascii=False, indent=2) + '\n'
    if args.output:
        args.output.write_text(encoded, encoding='utf-8')
    print(encoded, end='')
    return 0 if result['status'] == 'pass' else 1


if __name__ == '__main__':
    sys.exit(main())
