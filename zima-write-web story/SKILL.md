---
name: zima-write-web-story
description: Use when 用户要按卷章纲新写或续写中文小说、审读或局部润色现有片段、按约束重写正文、做跨章跨卷终审、检查红线与角色认知，或迁移小说正文流水线。不要用于新建卷纲、章纲或章节规划。
---

# zima-write-web-story

## 定位

这是正文写作、润色、校对和终审的通用源 skill。`zima-scroll-rod-and-chapter-outline` 按本书大纲生成项目配置、规划及适用配套材料；本 skill 验收并消费这些材料。项目文件不随源 skill 打包，不能把源目录里没有某本书的状态表误报为安装缺失。

它不从零重做卷纲/章纲。缺材料时按 [交接契约](references/handoff-contract.md) 定向补证或反馈上游，不靠猜测补齐本批硬连续事实，也不因缺表单就加载上游 skill 全文重做规划。只有源 skill 实际引用的通用资源不存在，才是打包问题。

## 开工与恢复

先确认作者要新写或续写、只收审稿意见、局部润色，还是明确授权重写。以下开工步骤与四阶段闭环适用于新写或续写正文批次。处理已有文本时，按[交接契约的范围分支](references/handoff-contract.md)确定版本、权限与保护范围。

1. 读项目规则、当前入口、本书配置和逐章进度，确认用户总范围、已接受正文与下一动作。
2. **首次为本书写正文时先定文风。** 读全书大纲中交代基调、人物和叙述视角的段落，对照本批章纲与分章执行卡（施工卡）。已有正文再看已接受章节的声音。核对本书已选模块；缺少可用记录时，到 `D:\knowledge base\zima-fiction` 按[文风模块选用](references/wiki-routing.md#文风模块选用)查读适合的模块原页。无库、库不可读或找不到合适模块，且用户尚未选定时，先用本章场景和用户讨论文风，选定后再开写。
3. 验收入口指向的唯一 `active` 当前执行包。核对书标识、包版本、章节范围、规划/事实/风格版本及验收证据。包中写明本章采用的文风模块、来源和具体用法。旧包若只有“风格待定”或题材标签，先补选并重新验收。输入包与执行包可在同一文件分区保存。
4. 读前 1–2 章相关正文及人物、术语、道具、伏笔状态相关行；缺硬事实先定向补证。材料按内容和阶段判断，可注明理由为 `N/A`，不空造术语表或跨卷表。
5. 零正文首批由主 agent 依据已审规划和初始事实初始化、验收并激活；已有正文按迁移接管提取实绩，保留已通过章节。恢复时从逐章未完成阶段继续。

同书续写从当前包复用已定模块，按本章场景说明怎样落笔。普通批次不默认通读全书大纲。偏移或执行包缺项先回读对应章纲/卷纲；新书、新卷、卷末、跨卷或无法解释的结构风险按需扩大读取。用户要求全书审查时，按其总范围执行，不以普通批次规则缩小任务。

## 执行闭环

`初稿 → 润色 → checker 审查 → 修复与复审 → 主 agent 终审及必要跨卷审查 → 已接受实绩入账 → 更新后续规划 → 下一包验收、激活`

- writer 默认先读 [表达阶段主用 skill 分工](references/expression-skills.md) 与 [human-writing-fiction.md](references/human-writing-fiction.md) 的适用规则与正向初稿部分，主用 `human-writing`；polisher 在初稿完成后主用 `humanizer-zh`，辅以 [humanizer-zh-fiction.md](references/humanizer-zh-fiction.md) 的小说边界。风格服从本书配置，主 agent 验收表达改动与内容保护；checker 保持事实审查职责。
- 章纲授权内可设计动作、对白和细节，不擅改关键因果、人物动机、事件次序或世界规则。润色保护必要情节容量与有意重复，不用句式或标点禁令机械改文；终章按规划收束，不强造下一章钩子。
- 草稿新增变化只是候选，主 agent 终审接受后才进入正式事实基线。正文版本变动使相关旧报告失效；规划或已接受事实变化使依赖执行包失效，重验后才能激活。
- 正文批次的四阶段职责与可见证据必须保留，可以由主 agent 本地顺序执行，不强制四个独立 agent。逐章保存阶段、正文版本、报告版本、未结事项和下一动作。
- 普通 checker 统一建立“执行包硬点 → 正文证据”表；包生成验收时承接章纲来源条目，发现遗漏/偏移再回读规划。
- 批次内阶段完成不等于终审完成。本批完成、用户指定范围完成、下一批可开工和全书完结分别判断。没有下一批不造包；授权范围内满足闸门即可继续，不每批强制等用户。

## 按需读取

| 任务 | 读取 |
|------|------|
| 材料验收、首批初始化、元数据与状态 | [handoff-contract.md](references/handoff-contract.md) |
| 工作集、事实裁决、失效与恢复 | [context-and-drift-protocol.md](references/context-and-drift-protocol.md) |
| 执行模式与 A/B/C/D 反馈 | [execution-modes-and-feedback.md](references/execution-modes-and-feedback.md) |
| 正文批次的顺序和落盘 | [workflow.md](references/workflow.md) |
| writer / polisher / checker / 主审职责 | [agent-contracts.md](references/agent-contracts.md) |
| 验收与结束判断 | [quality-gates.md](references/quality-gates.md) |
| 相邻几场读来雷同、揭晓是否提前、何时请人盲读 | [场景审读与盲读](references/scene-review.md) |
| 初稿表达与后置润色 | [expression-skills.md](references/expression-skills.md)、[human-writing-fiction.md](references/human-writing-fiction.md)、[humanizer-zh-fiction.md](references/humanizer-zh-fiction.md) |
| 首次选文风模块、换文风或定向补技法 | [wiki-routing.md](references/wiki-routing.md) |
| 三端 agent/rule 与契约路径 | [three-terminal-setup.md](references/three-terminal-setup.md) |

## 技法与输出

复用已验收技法包，按每章需要选择通常 1–3 个真实落点；不每批重复检索知识库。借鉴结构、节奏和场面调度，不复制原句、专名或可识别桥段。写前预审、终审复查项目红线。

批次交付记录正文路径与版本、四阶段证据、硬点覆盖、未结问题及修复复审、适用状态表的实绩更新或 `N/A` 理由、A/B/C/D 裁决、用户范围进度和下一动作。需要下一批时另记录新包验收与入口；暂停或范围结束时如实记录原因。
