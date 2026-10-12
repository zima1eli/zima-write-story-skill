# 三端统一配置说明

Codex、Claude Code、Cursor 共用本源 skill 的 [agent-contracts.md](agent-contracts.md)；运行方式可不同，职责和证据要求相同。三个角色加主 agent 是阶段分工，不强制四个独立进程。

## 安装与实际路径

源 skill 的通用 references 随源技能保存；本书配置、当前入口、执行包与事实表由上游按本书大纲生成，不随模板预置。复制运行时模板后，主 agent 在调用时提供并检查这些实际路径：

- `skill_root`：本源 skill 的安装根目录。
- `contract_path`：该根目录下 `references/agent-contracts.md` 的绝对路径。
- `profile_path`：本书配置实际路径。
- `current_entry_path`：本项目当前入口实际路径。
- `execution_package_path`：当前入口指向的执行包实际路径。

模板中的 `references/...` 按 `skill_root` 解析，不按项目工作目录猜测。同名 skill 有多个安装副本时固定本次实际使用的一个根目录。writer/polisher 的小说表达模块从同一根目录读取；检查其文件存在与可读，不能只有口头声明“已使用”。

若运行时不能读取源安装目录，可把所需通用契约与表达模块复制到项目可读的约定位置，记录源版本与实际路径并一同同步；不得留下指向不存在文件的引用。材料缺失按交接契约处理，不把本书尚未生成的表单当作源 skill 打包故障。

## Codex

```text
templates/codex/agents/content-writer.toml  -> 项目/.codex/agents/content-writer.toml
templates/codex/agents/polisher.toml        -> 项目/.codex/agents/polisher.toml
templates/codex/agents/outline-checker.toml -> 项目/.codex/agents/outline-checker.toml
```

主 agent 调用对应角色并传入实际路径、章节范围、包 ID/版本及所处理正文版本。没有独立角色能力时，本地依次履行契约并保存各阶段报告。

## Claude Code

```text
templates/claude/agents/content-writer.md  -> 项目/.claude/agents/content-writer.md
templates/claude/agents/polisher.md        -> 项目/.claude/agents/polisher.md
templates/claude/agents/outline-checker.md -> 项目/.claude/agents/outline-checker.md
```

沿用项目既有进度/状态目录，明确实际路径；不因模板提到 memory 就新增或修改用户的全局记忆。

## Cursor

```text
templates/cursor/rules/zima-content-writer.mdc  -> 项目/.cursor/rules/zima-content-writer.mdc
templates/cursor/rules/zima-polisher.mdc        -> 项目/.cursor/rules/zima-polisher.mdc
templates/cursor/rules/zima-outline-checker.mdc -> 项目/.cursor/rules/zima-outline-checker.mdc
```

按角色规则顺序执行，并提供相同实际路径和版本。即使由同一 agent 完成，也不得合并省略初稿、润色、checker 和主审证据。

## 同步与运行验证

修改职责先改本契约，再同步九份模板；writer 默认读取小说表达模块的正向初稿段，polisher 在初稿存在后读取润色段，checker 保留事实审查职责，主 agent 验收内容保护。

三端均须遵守：唯一 active 包验收、草稿候选与已接受实绩分离、正文变更后相关报告失效、修复复审及必要跨卷审查在入账前完成、后续规划更新在下一包激活前完成、逐章恢复不重写通过章节。普通 checker 使用执行包硬点对应；缺项才定向回读，用户全书审查优先。

还需统一情节容量、有意重复保护、按本书 POV 检查、缺硬事实不猜、不机械禁词禁标点、终章不强造钩子、无下一批不造包和授权内不每批暂停。

验证区分：模板格式与路径可读是静态检查；在目标客户端完成一个小型样例并核对实际正文、各阶段报告和版本，才说明运行时流程已验证。只复制文件不宣称三个客户端都已加载或运行成功。
