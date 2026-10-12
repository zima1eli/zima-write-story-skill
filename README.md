# zima-write-story-skill

两个可复用的中文小说源 skills：根据**每本书的大纲**生成配套材料，再交给正文流程写作、润色、审查和回写。具体小说事实和项目文件保存在小说项目中，不预装进源技能。

| 源目录 | 职责 |
| --- | --- |
| [zima-scroll-rod-and-chapter-outline](zima-scroll-rod-and-chapter-outline/SKILL.md) | 大纲解析、本书初始化、按需材料、卷章纲、规划审查、首批和续批交接 |
| [zima-write-web story](<zima-write-web story/SKILL.md>) | 验收执行包、正文、润色、事实检查、主审、实绩回写和断点恢复 |

目录名及技能标识沿用原版。正文技能的标识为 `zima-write-web-story`，源目录含空格。

## 使用流程

1. 将本书大纲、已有项目材料和要求范围交给上游。上游生成本书配置，说明来源、POV、风格依据、硬约束和设计空间；根据内容与阶段决定需要哪些材料，可合并文件。
2. 规划审查区分目录、结构规划和可直接扩写三种深度。首批按已审规划与初始状态验收并激活执行包，无需不存在的上一批报告。
3. 下游读取项目当前入口，核对执行包的书标识、范围、版本、来源及验收证据。按初稿、润色、检查、修复复审、主审顺序执行；可本地分角色，也可实际委派，均保留真实记录。
4. 主审接受后才把候选变化写入事实状态，再修订后续规划，验收并激活下一包。修订使受影响报告或包失效，恢复时从有效的逐章阶段继续。
5. 分别记录本批完成、用户范围完成、下一批就绪和全书结束。没有下一批时不造包；授权范围内的续批不默认反复请求许可。

初始化与包规范见[上游初始化说明](zima-scroll-rod-and-chapter-outline/references/project-initialization.md)；正文执行见[下游流程](<zima-write-web story/references/workflow.md>)。

## 小说表达

正文初稿与润色默认使用内置 [human-writing 小说适配](<zima-write-web story/references/human-writing-fiction.md>)，无需额外安装。基于卡兹克的 [human-writing](https://github.com/KKKKhazix/human-writing) 1.1.0 固定版本改编，保留[来源与适配差异](<zima-write-web story/third-party/human-writing/SOURCE.md>)及 [MIT 许可](<zima-write-web story/third-party/human-writing/LICENSE>)。

初稿重人物目标、对白意图、视角和场景变化；润色减少重复解说，同时保护人物声音、关键因果、有意重复、必要慢场景与伏笔。破折号、纠正句式等按小说语境判断，不设机械禁词或删字比例。本书约束优先，表达优化不能擅改关键事件与知情顺序。

## 备份与验证

- 优化前完整源文件备份：标签 `backup/source-skills-before-20261012`，提交 `329f09d59ddcfba9bef060baa869ec35c3c10ad6`。
- 实施范围与状态：[implementation-plan.md](docs/implementation-plan.md)。
- 原版行为观察：[baseline-observations.md](verification/baseline-observations.md)。
- 本轮改动、已执行检查和验证边界：[验证报告](verification/REPORT.md)。
- 两套评测文件共 42 个案例定义；定义数量不等于已执行数量。固定小型小说输入放在各自 `evals/fixtures/`。
- 源文件检查：Python 3.11+ 运行 `python -X utf8 scripts/verify_repository.py --self-test`。该检查验证格式、相对资源、fixture 和模板清单，不验证文学效果或客户端实际加载。

三端使用说明保留在各 skill 的 `references/three-terminal-setup.md`。本次未安装到真实小说项目或全局客户端；原有安装脚本未纳入本轮修复，不以模板可解析声称三端部署已验证。
