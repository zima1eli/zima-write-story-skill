# 三端通用安装说明

本 skill 的源目录是包含当前 `SKILL.md`、`references/` 和安装脚本的目录。以实际检出位置为准，不把某本小说的项目资料放进源目录。

同一份内容应同步到 Codex、Claude Code、Cursor 三端。不要只改其中一个副本。

## 目标目录

以某个小说项目根目录 `PROJECT_ROOT` 为例：

```text
PROJECT_ROOT/
├── .agents/skills/zima-scroll-rod-and-chapter-outline/   # Codex
├── .claude/skills/zima-scroll-rod-and-chapter-outline/   # Claude Code
└── .cursor/skills/zima-scroll-rod-and-chapter-outline/   # Cursor
```

每个目录都应包含：

```text
SKILL.md
CHANGELOG.md
references/
evals/
scripts/
```

`references/` 必须包含 `project-initialization.md`、`planning-harness.md` 和 `handoff-contract.md`；三端同步时不能只复制 `SKILL.md`，否则初始化、版本与交接规则会丢失。安装不要求另造一本书专属的 skill；本书资料放在项目已有文档中。

## 手工复制

PowerShell 示例：

```powershell
$src = (Get-Location).Path  # 在本 skill 源目录运行
$project = "D:\your\novel-project"

Copy-Item -Recurse -Force $src (Join-Path $project ".agents\skills\zima-scroll-rod-and-chapter-outline")
Copy-Item -Recurse -Force $src (Join-Path $project ".claude\skills\zima-scroll-rod-and-chapter-outline")
Copy-Item -Recurse -Force $src (Join-Path $project ".cursor\skills\zima-scroll-rod-and-chapter-outline")
```

## 脚本复制

在 skill 源目录运行：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/install-three-terminal-skills.ps1 -ProjectRoot "D:\your\novel-project"
```

脚本会复制到三端技能目录，并保留同名目录结构。

## 三端调用口径

| 端 | 调用方式 |
|----|----------|
| Codex | 用户说“写卷纲/章纲/根据大纲拆章节/规划下一卷”时触发本 skill |
| Claude Code | 在项目内由 `.claude/skills/` 发现；需要时直接点名 `zima-scroll-rod-and-chapter-outline` |
| Cursor | 在项目内由 `.cursor/skills/` 或规则系统读取；可在提示中写“按 zima-scroll-rod-and-chapter-outline 做卷纲/章纲” |

## 同步检查

更新后检查三端副本是否一致：

```powershell
$name = "zima-scroll-rod-and-chapter-outline"
$project = "D:\your\novel-project"

Get-FileHash "$project\.agents\skills\$name\SKILL.md"
Get-FileHash "$project\.claude\skills\$name\SKILL.md"
Get-FileHash "$project\.cursor\skills\$name\SKILL.md"
```

三端 hash 应一致。若不一致，以源目录为准重新复制。

同步后还应检查 `references/project-initialization.md`、`references/planning-harness.md` 与 `references/handoff-contract.md` 的 hash，而不只检查入口文件。
