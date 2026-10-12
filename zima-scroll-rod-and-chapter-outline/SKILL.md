---
name: zima-scroll-rod-and-chapter-outline
description: Use when 用户要写/优化卷纲、章纲、章节技法包、伏笔回收表、卷级审查、跨卷串联审查、项目进度更新，或提到“写卷纲”“写章纲”“拆章节”“规划下一卷/下一批”。不要用于直接扩写小说正文。
---

# zima-scroll-rod-and-chapter-outline

## 定位

这是正文写作之前的上游 skill：把全书大纲、项目设定、当前卷目标和已有进度，整理成可执行的卷纲、章纲、技法包、伏笔表、当前执行包和审查报告。

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
| 新建/优化卷纲、章纲、技法包 | `references/planning-harness.md`、`references/workflow.md`、`references/wiki-methodology-routing.md`、`references/quality-gates.md` |
| 既有正文接管、卷级接口卡、本批输入包 | `references/planning-harness.md`、`references/handoff-contract.md` |
| 卷末单卷审查、跨卷串联审查、更新进度 | `references/planning-harness.md`、`references/review-and-progress.md`、`references/quality-gates.md` |
| 吸收下游反馈、修订后续规划或当前执行包 | `references/planning-harness.md`、`references/handoff-contract.md` |
| 交给正文写作 | `references/planning-harness.md`、`references/handoff-contract.md` |
| 安装或同步到三端 | `references/three-terminal-setup.md` |

## 边界

- 卷纲回答“这一卷为什么非读不可”：目标、阻力、情绪阶梯、回报点、伏笔窗口和风险。
- 章纲回答“这一章怎么写才有推动力”：浓缩句、目标、冲突、必要条件、场景节拍、钩子和正文扩写技法。
- 章纲还要承担施工图职责：可写材料层、术语与角色认知路径、关键道具状态、伏笔窗口和允许/禁止表达。
- 已写正文优先作为事实基线；接管旧章节时先提取实绩，不因新流程或过期计划机械重写旧文。
- 技法包必须落到具体卷段或章节，不堆方法名。
- 可写材料层只提供物象、动作、对白遮掩、误读/错认、题材细节和节奏提示等短条目，不写正文段落或完整对白。
- 审查必须给出具体卷章、问题、影响和修复建议。
- 需要改卷级目标、人物关键动机、伏笔回收窗口时，先回到本 skill 更新上游产物，再进入正文写作。
- 当前执行包由主 agent 在批次终审后按本 skill 的规划口径生成；它吸收正文实绩与 A/B/C/D 反馈，是下一批正文的开写许可证。

## 输出交接

交给 `zima-write-web-story` 前，输出或确认交接包完整性：

- 当前卷纲。
- 本批章纲。
- 每章技法包。
- 每章可写材料层。
- 伏笔/回收表。
- 人物状态。
- 术语认知规划与角色认知路径。
- 关键道具状态路径。
- 卷级接口卡。
- 本批输入包。
- 当前执行包。
- 单卷/跨卷审查报告。
- 下一批风险。

缺项时先补上游产物，不要求下游加载本 skill 全文。
