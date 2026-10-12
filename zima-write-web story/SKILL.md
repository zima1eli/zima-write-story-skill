---
name: zima-write-web-story
description: Use when 用户要按小说卷纲/章纲批量写正文、继续写章节、润色校对章节批次、做跨章/跨卷终审、检查红线/术语认知/角色认知链，或迁移小说正文写作流水线。不要用于新建卷纲、章纲或章节规划。
---

# zima-write-web-story

## 定位

这是正文写作、润色、校对和终审的通用源 skill。`zima-scroll-rod-and-chapter-outline` 按本书大纲生成项目配置、规划及适用配套材料；本 skill 验收并消费这些材料。项目文件不随源 skill 打包，不能把源目录里没有某本书的状态表误报为安装缺失。

它不从零重做卷纲/章纲。缺材料时按 [交接契约](references/handoff-contract.md) 定向补证或反馈上游，不靠猜测补齐本批硬连续事实，也不因缺表单就加载上游 skill 全文重做规划。只有源 skill 实际引用的通用资源不存在，才是打包问题。

## 开工与恢复

先区分任务：以下开工步骤与四阶段闭环针对新写/续写正文批次。用户只要求润色或审查已有文本时，按 [交接契约的范围分支](references/handoff-contract.md) 建立本次文本、版本、约束和输出范围记录；不为此强造 active 包，也不冒称完成整批写作。已有项目材料仍按需要核对。

1. 读项目规则、当前入口、本书配置和逐章进度，确认用户总范围、已接受正文与下一动作。
2. 验收入口指向的唯一 `active` 当前执行包：书标识、包版本、章节范围、规划/事实/风格版本及验收证据必须对应本项目。输入包保存规划依据，执行包保存校准快照，可同文件分区保存。
3. 读前 1–2 章相关正文及人物、术语、道具、伏笔状态相关行；缺硬事实先定向补证。材料按内容和阶段判断，可注明理由为 `N/A`，不空造术语表或跨卷表。
4. 零正文首批由主 agent 依据已审规划和初始事实初始化、验收并激活；已有正文按迁移接管提取实绩，保留已通过章节。恢复时从逐章未完成阶段继续。

普通批次不默认通读全书大纲。偏移或执行包缺项先回读对应章纲/卷纲；新书、新卷、卷末、跨卷或无法解释的结构风险按需扩大读取。用户要求全书审查时，按其总范围执行，不以普通批次规则缩小任务。

## 执行闭环

`初稿 → 润色 → checker 审查 → 修复与复审 → 主 agent 终审及必要跨卷审查 → 已接受实绩入账 → 更新后续规划 → 下一包验收、激活`

- writer 默认先读 [小说表达模块](references/human-writing-fiction.md) 的适用规则与正向初稿部分；polisher 在初稿完成后读其适用规则与润色部分。风格服从本书配置，主 agent 验收表达改动与内容保护；checker 保持事实审查职责。
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
| 初稿表达与后置润色 | [human-writing-fiction.md](references/human-writing-fiction.md) |
| 缺技法、新类型或同类问题复发 | [wiki-routing.md](references/wiki-routing.md) |
| 三端 agent/rule 与契约路径 | [three-terminal-setup.md](references/three-terminal-setup.md) |

## 技法与输出

复用已验收技法包，按每章需要选择通常 1–3 个真实落点；不每批重复检索知识库。借鉴结构、节奏和场面调度，不复制原句、专名或可识别桥段。写前预审、终审复查项目红线。

批次交付记录正文路径与版本、四阶段证据、硬点覆盖、未结问题及修复复审、适用状态表的实绩更新或 `N/A` 理由、A/B/C/D 裁决、用户范围进度和下一动作。需要下一批时另记录新包验收与入口；暂停或范围结束时如实记录原因。
