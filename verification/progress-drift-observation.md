# 实写中的进度滞后观察与修复

主 agent 在实写子任务收尾前回读了 `prose-run/RUN_LOG.md`、`state/accepted-v2.md` 和 `PROJECT_PROGRESS.md`。此时运行记录已有 S13：两章已接受入账、B02已消费；事实表也为 `accepted-v2`。但总进度仍返回初始文本：

```text
| 已写/已接受正文 | 0/2、0/2 | 无正文版本 | 本轮不写正文，不将计划当实绩 |
- 当前批次：B01仅001已通过首批交接验收；当前执行包 packages/execution-B01-v1.md / v1，状态active。
```

这是主 agent 本轮工具回读的摘录。没有在修复前另存带时间戳的完整进度副本，不把初始快照伪称为 S13 现场快照。子任务随后同步了 README、当前入口和总进度，最终均为两章已接受、无 active；正文和有效接受记录没有重写。

原流程已要求批后更新进度，但本次只更新日志/事实/当前包时没有及时发现总进度滞后。现将“入口、总进度/逐章恢复、接受基线互相一致”明确列为续批激活与收尾前的回读门。规则独立复核见 [source-review.md](source-review.md) 最后追加节；新的独立情境推演见 [lifecycle-run/report.md](lifecycle-run/report.md) 第八项。

对实际修复后的项目补三项机械检查：最终总进度逐章接受及基线一致、历史零章进度作为反例不能通过终态门、当前入口无 active 且指向最终事实。与原 61 项合计 **64 项、0 失败**，结果在 [prose-verification.json](prose-run/evidence/prose-verification.json)。该反例验证终态记录门，不冒称实际发生了一次自动续批拦截。
