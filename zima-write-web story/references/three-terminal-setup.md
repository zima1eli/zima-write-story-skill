# 三端统一配置说明

本 skill 支持 Claude Code、Codex、Cursor 三端统一写作流程。三端使用同一职责契约：`references/agent-contracts.md`。

## Codex

复制：

```text
templates/codex/agents/content-writer.toml  -> 项目/.codex/agents/content-writer.toml
templates/codex/agents/polisher.toml        -> 项目/.codex/agents/polisher.toml
templates/codex/agents/outline-checker.toml -> 项目/.codex/agents/outline-checker.toml
```

使用方式：主 agent 调用 `content-writer`、`polisher`、`outline-checker`。

## Claude Code

复制：

```text
templates/claude/agents/content-writer.md  -> 项目/.claude/agents/content-writer.md
templates/claude/agents/polisher.md        -> 项目/.claude/agents/polisher.md
templates/claude/agents/outline-checker.md -> 项目/.claude/agents/outline-checker.md
```

如果项目已有 `.claude/memory/`，优先沿用；若只有 `.Codex/memory/` 或 `.codex/memory/`，在 agent 指令里写明实际路径。

## Cursor

Cursor 通常不是三 agent 调度模型，使用 rules 统一行为。

复制：

```text
templates/cursor/rules/zima-content-writer.mdc  -> 项目/.cursor/rules/zima-content-writer.mdc
templates/cursor/rules/zima-polisher.mdc        -> 项目/.cursor/rules/zima-polisher.mdc
templates/cursor/rules/zima-outline-checker.mdc -> 项目/.cursor/rules/zima-outline-checker.mdc
```

使用方式：在 Cursor 中明确要求“按 zima-content-writer / zima-polisher / zima-outline-checker 规则执行”。如果 Cursor 的规则系统支持自动匹配，可保留模板中的 `description`。

## 同步原则

- 改职责时先改 `references/agent-contracts.md`，再同步三端模板。
- 写作和润色必须带技法包。
- 审查不带技法包。普通正文批次优先读取当前入口、active 当前执行包和正文，先做硬点对应；发现缺失、偏移或状态不明时再升级回读章纲、卷纲，只在新项目、新卷、跨卷、卷末或大纲偏离风险时读取全书大纲。
- 当前执行包闸门必须三端统一：content-writer、polisher、outline-checker 不得生成下一批执行包；主 agent 终审、更新状态并吸收 A/B/C/D 反馈后生成和登记 active 执行包。
- 情节容量门必须三端统一：字数服务情节，不设固定字数目标，也不能把必要场景压成剧情摘要。
- 动作与道具状态检查必须三端统一：content-writer 写完自检，polisher 标出近距重复动作，outline-checker 把重复动作导致的状态矛盾归入连续性审查。
- 有意重复动作保护必须三端统一：重复动作不能只因“重复”被删除或拦截；若它服务纠结、迟疑、压抑、强迫确认、情绪升级、仪式感或规则压迫，并有停顿、缩回、换对象、生理反应、环境反馈、动作幅度变化或选择后果，应标为保留。
- 术语认知状态表必须三端统一：content-writer 记录新术语首次知晓证据，polisher 检查 POV 认知越界和设定泄露，outline-checker 复核角色首次知晓前不得使用正式术语，主 agent 在批次终审前更新或确认当前卷术语表。
- 角色认知链检查必须三端统一：content-writer 写完自检姓名、称呼、身份、关系、旧事、地点、规则、道具来源和他人行动是否有信息来源；polisher 处理无来源称呼和普通信息越界，或强化伏笔型异常知情；outline-checker 把信息来源缺失归入连续性审查，并区分”信息来源缺失 / 轻微表达误导 / 伏笔型异常知情”。
- 叙述者认知边界检查必须三端统一：content-writer 写完自检新场景/新地点/新身份/时代背景等确定标签是否在角色通过观察和推断后才给出；polisher 将提前标签改为感官证据链，不能只加”像””似乎”软化词；outline-checker 把场景标签前置/叙述者认知越界归入连续性审查，标黄或标红，不接受表面修补。
- 三端报告格式保持一致，便于主 agent 汇总。
