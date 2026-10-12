# main 合并与仓库用途核对

日期：2026-10-12。用户已授权将工作分支合并到 main，保留修改前备份，补充仓库描述与主要用途。

## 合并结果

- 来源分支：`codex/source-skills-human-writing`，分支提交 `85643deb671e9866008256dc493ab91c45044970`。
- main 使用保留合并记录的方式合并，合并提交 `0bc5c42d6b5800945c74cf8486d407c4941422b3`，已推送并回读远端引用确认。
- 合并提交的完整文件树与工作分支相同，130/130 个文件的工作区字节与提交内容一致；合并没有丢失原有说明、小样或验证证据。
- 修改前备份标签 `backup/source-skills-before-20261012` 保留，指向 `329f09d59ddcfba9bef060baa869ec35c3c10ad6`；本地、远端引用一致。备份中的 31/31 个源文件再次与桌面原件逐字节比对一致。

逐文件对象、SHA256、合并时远端引用及计数见 [main-merge-integrity.json](main-merge-integrity.json)。之后的用途说明和本次核对记录单独提交到 main，不改变源技能内容；最终提交以 main 的最新引用为准。

## 两套源 skills 与配套文件

| 项目 | 合并后核对结果 |
| --- | --- |
| 源文件总数 | 38：上游 13、下游 25；与已验证工作分支的源文件树相同 |
| 技能入口 | 2 个；分别重新运行 skill-creator 的 quick_validate，均为 `Skill is valid!` |
| references | 17：上游 8、下游 9，含按大纲初始化与 human-writing 小说适配 |
| 三端角色模板 | 9 个；3 份 TOML 可解析，3 个角色在三端的主体一致；另对 6 个 Markdown/MDC 的 YAML 头做实际解析 |
| 评测与固定输入 | 2 份 eval JSON，共 42 个定义：上游 19、下游 23；3 个 fixture 齐全 |
| 来源和维护材料 | 2 个 CHANGELOG、原安装脚本、human-writing 固定来源说明及 MIT 许可齐全 |
| 资源引用与结构工具 | 相对资源和 fixture 检查通过，工具的 8 项正反向自测通过；结果见下方记录 |

合并后重新执行 `python -X utf8 scripts/verify_repository.py --self-test --output verification/main-merge-structure-results.json`，结果见 [main-merge-structure-results.json](main-merge-structure-results.json)。

6 份 Markdown/MDC 模板的 YAML 实际解析结果见 [main-merge-template-results.json](main-merge-template-results.json)。

独立只读审查另扫描了源文件中的 31 个 Markdown 本地文件链接，未发现断链；回读初始化、交接、工作流、质量门、角色契约、事实裁决、恢复和小说表达规则，未发现阻断性缺失。按本书大纲生成材料、零正文首批、唯一 active 包、审后接受实绩、规划更新、包失效、续批及结束均有对应流程。

顺便更正原验证报告的一处数量笔误：下游评测定义为 23，原文的“22”与合计 42 不符；没有修改评测内容。

## 仓库描述与主要用途

GitHub 仓库 description 已从空值更新为：

> 可复用的中文小说源 Skills：根据每本书的大纲生成配套材料与执行包，衔接正文写作、human-writing 小说润色、审查和实绩回写；提供 Codex、Claude Code、Cursor 三端角色模板。

通过 GitHub 接口回读确认保存成功，默认分支仍为 main；本次只修改 description 字段，见 [main-merge-github-metadata.json](main-merge-github-metadata.json)。

[README](../README.md) 新增主要用途与适用对象：从大纲准备材料、规划交接、正文与小说表达、持续更新与恢复、跨小说复用。明确仓库保存源规则和模板，每本书的材料按其大纲生成，验证小样不作为小说通用事实。

## 当前状态与验证边界

- 已完成：工作分支合并并推送 main、备份标签保留、合并后完整性复查、GitHub 描述及 README 用途补充。
- 当前批次：合并收尾；本报告、用途说明和检查记录随 main 保存。
- 阻塞：无。
- 下一入口：main 的 [README](../README.md)；具体小说先进入上游初始化，再按当前有效执行包进入正文流程。

本次确认文件与流程完整性。42 是评测定义数量，不表示全部执行；未新增三端真实安装或加载、外部知识库可达性、长篇文学质量的验证。原安装器和此前实写验证的具体限制仍以 [原验证报告](REPORT.md) 为准，未扩大已验证结论。
