# humanizer-zh 来源与改编记录

- 原作者/仓库：op7418 / [Humanizer-zh](https://github.com/op7418/Humanizer-zh)
- 许可：MIT，见 [许可证](LICENSE)
- 上游参考：blader/humanizer v3.0.0、Humanizer-zh PR 39、hardikpandya/stop-slop
- 本地改编文件：[references/humanizer-zh-fiction.md](../../references/humanizer-zh-fiction.md)
- 调用说明：[references/expression-skills.md](../../references/expression-skills.md)

## 引用来源

| 来源 | 本地用途 |
|------|----------|
| [Humanizer-zh SKILL.md](https://github.com/op7418/Humanizer-zh/blob/main/SKILL.md) | A–F 六组 31 条模式的分类、检查线索用法、编辑约束优先级、交付前核对 |
| [blader/humanizer v3.0.0](https://github.com/blader/humanizer/blob/v3.0.0/SKILL.md) | A–E 分类、声音校准与文件模式的参考来源 |
| [Humanizer-zh PR 39](https://github.com/op7418/Humanizer-zh/pull/39) | 中文分类与 F 组补充检查点的基础 |
| [hardikpandya/stop-slop](https://github.com/hardikpandya/stop-slop) | 简洁表达与编辑检查的参考来源 |

## 改编范围

本源 skill 不复制原版全文，只在 [references/humanizer-zh-fiction.md](../../references/humanizer-zh-fiction.md) 中保留小说润色必需的约束与六组模式的取用说明。以下同时标明共享原则与小说适配，不把共享原则虚称为原版缺陷：

| 原版原则或适用范围 | 本源 skill 的沿用与小说适配 |
|---------|-----------|
| 模式清单以通用中文文章、评论、文档为语境 | 语境改为小说正文，标注每组在小说场景的实际取用重点 |
| 假对比需要检查，真实纠正和独立信息应保留 | 沿用该原则，结合人物对白的语用功能判断，不预设某本书的特殊保留项 |
| 通用文章场景项（客服腔、装饰性标题） | 按小说体例与剧情功能判断，区分编辑残留和有意的角色对白或书信，不为凑项生造改写 |
| 模式是检查线索，没有问题的表达可保留 | 沿用上下文判断，不把模式命中升级为小说质量硬门 |
| 重复同一信息可合并，独立信息和有意强调不强删 | 在小说中进一步区分状态矛盾、无增量冗余与有意重复；状态矛盾交 checker 和主 agent |
| 不机械禁用固定句式或标点 | 破折号、冒号、纠错对白、排比按语境判断，本书明确禁用项按本书红线执行 |

## 未移植内容

- 不移植原版的检测或评分脚本，不把"词形清零"或命中率设为小说质量门。
- 不移植原版面向论坛长帖、客服回复、邮件和发布说明的文体分支。
- 不把原版示例当作本书样章，不引入其专名、人物或语域。

外部 `humanizer-zh` skill 可用时以它为准；本目录只记录来源与本项目差异。
