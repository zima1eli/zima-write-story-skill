# 首批交接验收

验收对象：rain-before-stop，B01，仅第001章，input-B01-v1与execution-B01-v1；用户两章规划范围不变。验收者：Codex执行代理verify_new_book；本轮上游自检，未运行下游实际正文写作。日期2026-10-12。

当前结论：首批上游交接验收通过，B01仅001可开写。input-B01-v1作为已验收规划依据登记active，execution-B01-v1为唯一active正文执行入口。002已有已审可写规划，但其B02执行包必须在001终审接受并入账后另行验收。

## 核对职责

| 项目 | 要核对的实际证据 |
|---|---|
| 本书与范围 | 两包和00-CURRENT、PROJECT_PROGRESS均为rain-before-stop、B01仅001；总范围001—002 |
| 规划版本 | outline-v1原文副本与源校验一致；planning-v1覆盖两章全文 |
| 事实版本 | initial-v1明确零正文，初始条件来自大纲；未来末态未入账 |
| 风格版本 | 两包均引用book-config.md / style-v1，来源是用户要求而非虚构样章 |
| 适用材料 | 配置职责表所列必需/条件材料均可定位；不适用项有理由 |
| 规划内容 | reviews/planning-review-v1.md逐项语义审查通过，已记录修正及残余风险 |
| 下游可执行性 | execution分章卡、硬软门、回读、待正文覆盖表、反馈及批后顺序完整 |
| 唯一入口 | 只有execution-B01-v1是当前正文执行入口；input只作为规划依据 |
| 真实阶段 | 0章正文，无上一批、无正文卷末、无跨卷验收，不拿结构核验冒充正文完成 |

## 首批状态转换

两包先以draft写入。落盘读取与校验通过之后，记录首次验收并登记active；不存在被替代旧执行包。本记录及evidence/verification.json共同供下游核验，文件存在检查本身不代替上表内容审查。

## 首轮核验发现与修复

- 机械问题：首轮40项检查有1项失败，README提前链接尚未生成的最终verification.json。首次报告保留为evidence/verification-draft-initial.json；draft阶段改链当前实际报告，最终报告生成后再加最终链接。
- 范围措辞问题：配置中“规划范围与当前批次相同”残留。主审回读发现后改为总规划001—002、当前B01仅001；包元数据和入口同步为首章范围。
- 以上修复不涉及重做章纲或修改原大纲。复核evidence/verification-draft.json为40项检查、零失败；本轮语义审查另见planning-review-v1.md，不用机械计数代替可写性判断。

## 验收结果与限制

- 本书/批次一致：rain-before-stop / B01 / 001；用户两章可写总目标保持，已达2/2规划覆盖。
- 版本一致：outline-v1、planning-v1、initial-v1、style-v1；原始大纲副本与源文件SHA256一致。
- 首章初始状态、各项材料、技法、认知来源、道具和章间接口可定位；无阻断待定；条件不适用项已有理由。
- 生命周期：两包draft→本轮验收→active；无旧active包；唯一入口00-CURRENT指向execution-B01-v1，B02未生成。
- 最终激活状态落盘核验：evidence/verification.json；可用verify-project.ps1重复核验。
- 已完成：本次上游初始化、两章施工图及首章交接验收。未完成：正文写作、正文润色与审查、已接受实绩入账、B02续批验收、全书终审。
- 真实限制：未独立运行下游正文写作；本报告不能证明正文文学质量，也不能替代下游接手时对包版本的复核。
