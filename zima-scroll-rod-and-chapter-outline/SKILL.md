---
name: zima-scroll-rod-and-chapter-outline
description: Use when 用户要根据本书大纲初始化配套资料、写/优化卷纲章纲与章节技法包、安排伏笔回收、做规划/卷级/跨卷串联审查、更新进度，或规划首批/下一批。不要用于直接扩写小说正文。
---

# zima-scroll-rod-and-chapter-outline

## 定位

这是正文写作之前的上游 skill：根据每本书的大纲、用户要求范围与深度，生成本书配置及适用配套资料，再整理为卷纲、章纲、技法包、输入包、执行包和审查记录。本书事实留在项目中，源 skill 只维护通用生成规则。

它不写正文，不润色正文，也不读取下游写作 skill 全文。需要进入正文扩写时，只输出交接包或当前执行包给 `zima-write-web-story`。

## 先读项目，再补通用技法

在项目目录中工作时，先读取项目已有信息，避免用通用方法覆盖项目事实：

1. 当前入口与项目说明：`AGENTS.md`、`00-CURRENT.md`（或项目等价入口）、`PROJECT_PROGRESS.md`、红线规范、memory、现有卷纲/章纲。
2. 当前任务材料：全书大纲、当前卷目标、已有正文或审查报告、用户指定的章节范围。
3. 项目内已有上游产物：卷纲、章纲、伏笔表、人物状态、跨卷审查、下一批风险。
4. 通用方法论：按 `references/wiki-methodology-routing.md` 检索 `D:\knowledge base\zima-fiction\wiki`，只借结构、机制、节奏和场面调度。

不要为了规划卷纲/章纲读取 `raw/` 原文；不要访问 `D:\knowledge base\zima-ai`。

## 按需读取 references

只读取当前任务需要的文件：

| 任务 | 读取 |
|------|------|
| 从大纲初始化本书、首批启动、判断资料适用性/成熟度、包版本与批后更新 | `references/project-initialization.md`，再按下列任务读取细节 |
| 新建/优化卷纲、章纲、技法包 | `references/planning-harness.md`、`references/workflow.md`、`references/wiki-methodology-routing.md`、`references/quality-gates.md` |
| 既有正文接管、卷级接口卡、本批输入包 | `references/planning-harness.md`、`references/handoff-contract.md` |
| 卷末单卷审查、跨卷串联审查、更新进度 | `references/planning-harness.md`、`references/review-and-progress.md`、`references/quality-gates.md` |
| 吸收下游反馈、修订后续规划或当前执行包 | `references/planning-harness.md`、`references/handoff-contract.md` |
| 交给正文写作 | `references/planning-harness.md`、`references/handoff-contract.md` |
| 安装或同步到三端 | `references/three-terminal-setup.md` |

## 边界

- 卷纲回答“这一卷为什么非读不可”：目标、阻力、情绪阶梯、回报点、伏笔窗口和风险。
- 章纲回答“这一章怎么写才有推动力”：浓缩句、目标、冲突、必要条件、场景节拍、钩子和正文扩写技法。
- 要求可直接扩写的章纲承担施工图职责：可写材料层及本章适用的认知、道具、伏笔等连续性约束；目录、结构与扩写深度分别记录。
- 已接受正文优先作为事实基线；接管旧章节时先核实接受状态、提取实绩，不因新流程或过期计划机械重写旧文。
- 技法包必须落到具体卷段或章节，不堆方法名。
- 可写材料层只提供物象、动作、对白遮掩、误读/错认、题材细节和节奏提示等短条目，不写正文段落或完整对白。
- 审查必须给出具体卷章、问题、影响和修复建议。
- 需要改卷级目标、人物关键动机、伏笔回收窗口时，先回到本 skill 更新上游产物，再进入正文写作。
- 规划与事实、零正文首批、后续包更新及唯一 `active` 入口，统一遵守 `references/project-initialization.md`。本书表达配置交给下游，其默认按 `human-writing` 小说适配润色。

## 输出交接

交给 `zima-write-web-story` 前，按 `references/handoff-contract.md` 检查必需材料、条件适用项、版本和验收证据。可合并文件，不以模板数量判断完整性；缺失会阻断开写的内容先补齐，不要求下游加载本 skill 全文。当前批次就绪不替代用户全范围目标完成。
