# zima-write-story-skill

两个可复用的中文小说源 skills：根据**每本书的大纲**生成配套材料，再交给正文流程写作、润色、审查和回写。具体小说事实和项目文件保存在小说项目中，不预装进源技能。

| 源目录 | 职责 |
| --- | --- |
| [zima-scroll-rod-and-chapter-outline](zima-scroll-rod-and-chapter-outline/SKILL.md) | 大纲解析、本书初始化、按需材料、卷章纲、规划审查、首批和续批交接 |
| [zima-write-web story](<zima-write-web story/SKILL.md>) | 验收执行包、正文、润色、事实检查、主审、实绩回写和断点恢复 |

目录名及技能标识沿用原版。正文技能的标识为 `zima-write-web-story`，源目录含空格。

## 主要用途

面向使用 AI 辅助创作中文小说、需要持续推进多章或多卷作品的作者，也适合维护小说创作流程和角色模板的使用者。

- **从大纲准备开写条件**：根据本书题材、大纲深度和创作要求，生成本书配置、人物与世界状态、卷章规划及当前所需材料；记录已定事实、可设计部分和待定项。
- **把规划交给正文执行**：生成有范围、版本和验收依据的首批或续批执行包，衔接正文初稿、润色、检查、修复复审及主审。
- **改善小说表达**：在初稿和润色中分用各自擅长的表达 skill——初稿主用 `human-writing` 的虚构写作部分，润色主用 `humanizer-zh` 的编辑规则，减少机械解说和套路表达，同时保护人物声音、事件因果、视角、伏笔及有意重复。两个 skill 不可用时用本仓库内的适配兜底文件。
- **持续更新与恢复**：将审查接受的正文实绩回写，再更新后续规划和执行包；处理旧包失效、逐章断点恢复、范围完成与全书收尾。
- **复用和维护创作流程**：同一套源技能用于不同小说，提供 Codex、Claude Code、Cursor 三端角色模板，以及固定输入、评测定义和可复核的验证记录。

本仓库保存可复用的技能规则、参考材料和模板。每本小说的配套材料须根据其大纲生成，实际路径与事实状态保存在该小说项目中；仓库中的小型小说项目仅用于验证。

## 使用流程

1. 将本书大纲、已有项目材料和要求范围交给上游。上游生成本书配置，说明来源、POV、风格依据、硬约束和设计空间；根据内容与阶段决定需要哪些材料，可合并文件。
2. 规划审查区分目录、结构规划和可直接扩写三种深度。首批按已审规划与初始状态验收并激活执行包，无需不存在的上一批报告。
3. 下游首次准备写正文时，先读全书大纲、当前章纲和执行卡，核对本书已经选定的文风。文风待定时，到 `D:\knowledge base\zima-fiction` 查阅相符的文风模块，记录模块名称、来源及本章具体写法。没有可用知识库或合适模块时，用当前场景和作者讨论写法，选定后开写。续章复用仍然适用的选择。
4. 下游核对项目当前入口和执行包的书标识、范围、版本、来源及验收证据。初稿、润色、检查、修复复审和主审可本地分角色执行，也可实际委派，各阶段保留真实记录。
5. 主审接受后才把候选变化写入事实状态，再修订后续规划，验收并激活下一包。修订使受影响报告或包失效，恢复时从有效的逐章阶段继续。
6. 分别记录本批完成、用户范围完成、下一批就绪和全书结束。没有下一批时不造包；授权范围内的续批不默认反复请求许可。

初始化与包规范见[上游初始化说明](zima-scroll-rod-and-chapter-outline/references/project-initialization.md)；正文执行见[下游流程](<zima-write-web story/references/workflow.md>)。

## 小说表达

正文初稿与润色分用两个外部 skill：`human-writing` 负责初稿的正向生成，`humanizer-zh` 负责润色的定点修改。两者是外部安装项，按 [表达阶段主用 skill 分工](<zima-write-web story/references/expression-skills.md>) 的解析顺序定位实际路径；不可用时用本仓库的 [human-writing-fiction.md](<zima-write-web story/references/human-writing-fiction.md>) 与 [humanizer-zh-fiction.md](<zima-write-web story/references/humanizer-zh-fiction.md>) 兜底，并在阶段报告注明。`humanizer-zh` 源自 [op7418/Humanizer-zh](https://github.com/op7418/Humanizer-zh)（MIT），来源与许可见 [third-party/humanizer-zh](<zima-write-web story/third-party/humanizer-zh/SOURCE.md>)；`human-writing` 基于卡兹克的 [human-writing](https://github.com/KKKKhazix/human-writing) 1.1.0 固定版本改编，保留[来源与适配差异](<zima-write-web story/third-party/human-writing/SOURCE.md>)及 [MIT 许可](<zima-write-web story/third-party/human-writing/LICENSE>)。

初稿重人物目标、对白意图、视角和场景变化；润色减少重复解说，同时保护人物声音、关键因果、有意重复、必要慢场景与伏笔。破折号、纠正句式等按小说语境判断，不设机械禁词或删字比例。本书约束优先，表达优化不能擅改关键事件与知情顺序。

## 备份与验证

- 优化前完整源文件备份：标签 `backup/source-skills-before-20261012`，提交 `329f09d59ddcfba9bef060baa869ec35c3c10ad6`。
- 实施范围与状态：[implementation-plan.md](docs/implementation-plan.md)。
- 原版行为观察：[baseline-observations.md](verification/baseline-observations.md)。
- 本轮改动、已执行检查和验证边界：[验证报告](verification/REPORT.md)。
- 工作分支已合并到 `main`；合并后的文件、备份及仓库描述核对见[合并验证报告](verification/main-merge-report.md)。
- 两套评测文件共 56 个案例定义。固定小型小说输入放在各自 `evals/fixtures/`。2026-11-16 实际运行的表达分工与通用边界用例见[同步验证记录](verification/2026-11-16-skill-sync.md)。
- 首次选文风、有库与无库、同书续章和局部润色的实际表现见[2026-11-26 定向试跑](verification/2026-11-26-prose-style.md)。
- 关键章盲读、跨场重复、原句还原和两种叙述声音的同题对照见[四组试验与采纳结论](verification/sepia-20261127/results.md)。
- 源文件检查：Python 3.11+ 运行 `python -X utf8 scripts/verify_repository.py --self-test`。该检查验证格式、相对资源、fixture 和模板清单，不验证文学效果或客户端实际加载。

三端使用说明见各 skill 的 `references/three-terminal-setup.md`。核对项目安装版本时，比对项目技能入口及运行时角色文件与发布提交。客户端是否已加载该版本，可在新会话中按相应入口试跑核验。
