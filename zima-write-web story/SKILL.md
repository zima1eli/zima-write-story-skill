---
name: zima-write-web-story
description: Use when 用户要按小说卷纲/章纲批量写正文、继续写章节、润色校对章节批次、做跨章/跨卷终审、检查红线/术语认知/角色认知链，或迁移小说正文写作流水线。不要用于新建卷纲、章纲或章节规划。
---

# zima-write-web-story

## 定位

这是正文写作、润色、校对和终审的下游 skill。它接收 `zima-scroll-rod-and-chapter-outline` 的卷纲、章纲、技法包、伏笔表和审查报告，按批次产出正文并完成质量门。

它不负责从零规划卷纲/章纲。上游交接包缺失时，先提醒补齐上游产物；不要加载上游 skill 全文临时重做规划。

## 默认读取顺序

普通正文批次只读当前工作集，避免通读全书占用上下文：

1. 项目级规则与当前入口：`AGENTS.md`、`CLAUDE.md`、`00-CURRENT.md` 或等价当前口径文件。
2. 当前执行包：当前事实、硬门、软门、分章施工卡、回读触发器和写后覆盖表。
3. 前 1-2 章正文、本章草稿/目标，以及术语、角色、关键道具和伏笔状态的相关行。
4. `references/context-and-drift-protocol.md`：上下文预算、风险升级回读和偏移处理。
5. 若存在项目级 skill，再按项目 profile、风格锚点、红线和专项 references 补充项目事实。
6. `references/execution-modes-and-feedback.md`、`references/workflow.md`、`references/agent-contracts.md`、`references/quality-gates.md`：流程、角色和完成门。
7. `references/wiki-routing.md`：只在技法缺失、新类型首次出现或同类问题连续复发时读取。

只在这些场景读取全书大纲：新项目、新卷开始、跨卷批次、卷末审查、跨卷审查、卷纲明显偏离、当前卷材料无法回答伏笔/终局/人物状态问题。

已有正文接入新流程时，先执行迁移接管：把已写正文当作事实基线，提取人物、关系、道具、术语、角色认知、伏笔和风险实绩；不因新流程机械重写旧章节。

## 执行边界

- 正文写作：按卷纲和章纲扩写，不随意改卷级目标、人物关键动机、伏笔回收窗口。
- 润色：只改表达、节奏、视角、细节和红线风险，不改事件顺序。
- 校对：逐条对照卷纲、章纲、正文证据和项目状态，红色问题必须修。
- 主 agent 终审：复核跨章连续性、术语认知、角色认知链、动作与道具状态、红线和下一批风险。

## 按需读取 references

| 任务 | 读取 |
|------|------|
| 判断上游材料是否够写正文 | `references/handoff-contract.md` |
| 判断当前工作集、风险回读和偏移 | `references/context-and-drift-protocol.md` |
| 判断执行模式和下游反馈 | `references/execution-modes-and-feedback.md` |
| 执行正文批次、润色、校对、终审 | `references/workflow.md`、`references/agent-contracts.md`、`references/quality-gates.md` |
| 建立或刷新技法包 | `references/wiki-routing.md` |
| 三端 agent/rule 同步 | `references/three-terminal-setup.md` |

## 技法与红线

每批写作前建立技法包，但技法包不是方法名列表。每章只选 1-3 个能落地的技法，说明它们如何服务场景调度、冲突推进、细节、对话或章末钩子。

创作借鉴只借结构、节奏、机制和场面调度，不复制原文句子、人物、专名或可识别桥段。

写作前预审红线，终审再查红线。危险内容只写结果和影响，不写可复现步骤；真实平台、真实公司、联系方式、血腥色情和时政风险按项目规范处理。

## 输出

每个正文批次结束时必须输出或记录：

- 完成章节与保存路径。
- 本批技法包及落地情况。
- 章纲覆盖与偏差。
- 红色问题修复结果。
- 术语认知状态表：已更新 / 本批无新增 / 有待复核项。
- 角色认知链、动作与道具状态、红线检查结论。
- content-writer、polisher、outline-checker 和主 agent 的可见报告或证据。
- 下游反馈单：A/B/C/D 级与处理动作。
- 下一批风险。
- 下一批 active 当前执行包：已由主 agent 生成并登记 / 本批暂停，等待上游修订。未登记 active 执行包时，不得进入下一批正文。
