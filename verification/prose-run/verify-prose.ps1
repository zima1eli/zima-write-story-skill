param([string]$ProjectRoot = $PSScriptRoot)
$ErrorActionPreference = 'Stop'
$root = (Resolve-Path -LiteralPath $ProjectRoot).Path
$checks = [System.Collections.Generic.List[object]]::new()
function Add-Check([string]$Name, [bool]$Passed, [string]$Detail) {
    $checks.Add([ordered]@{ name=$Name; passed=$Passed; detail=$Detail })
}
function Hash-Of([string]$Relative) {
    (Get-FileHash -LiteralPath (Join-Path $root $Relative) -Algorithm SHA256).Hash
}

# 此脚本只核验持久化与生命周期。剧情和文笔依据真实阶段语义报告。
$manifest = Get-Content -LiteralPath (Join-Path $root 'evidence/initial-snapshot-manifest.json') -Raw | ConvertFrom-Json
foreach ($item in $manifest) {
    $relative = 'history/initial-handoff/' + $item.path
    Add-Check "初始快照保留：$($item.path)" ((Hash-Of $relative) -eq $item.sha256) $relative
}
foreach ($relative in @('sources/outline.md','book-config.md','planning.md','state.md','reviews/planning-review-v1.md','reviews/handoff-acceptance-v1.md','verify-project.ps1','evidence/verification.json')) {
    $item = $manifest | Where-Object { $_.path.Replace('\','/') -eq $relative }
    Add-Check "原证据未覆盖：$relative" (($null -ne $item) -and ((Hash-Of $relative) -eq $item.sha256)) '与接手快照SHA256比较'
}
foreach ($chapter in @('001','002')) {
    $draft = "prose/$chapter-draft-v1.md"
    $polished = "prose/$chapter-polished-v2.md"
    $final = "prose/$chapter-final-v2.md"
    $stages = if ($chapter -eq '001') { @('S02-draft-001','S03-polished-001','S04-checked-001','S05-accepted-001') } else { @('S09-draft-002','S10-polished-002','S11-checked-002','S12-accepted-002') }
    $records = @($stages | ForEach-Object { Get-Content -LiteralPath (Join-Path $root "evidence/stages/$_.json") -Raw | ConvertFrom-Json })
    Add-Check "$chapter 初稿阶段哈希" ((Hash-Of $draft) -eq $records[0].Hash) $draft
    Add-Check "$chapter 润色阶段哈希" ((Hash-Of $polished) -eq $records[1].Hash) $polished
    Add-Check "$chapter checker对应终稿" ((Hash-Of $final) -eq $records[2].Hash) $final
    Add-Check "$chapter 主审接受对应终稿" ((Hash-Of $final) -eq $records[3].hash) $final
    Add-Check "$chapter 初稿和润色稿确有版本差异" ((Hash-Of $draft) -ne (Hash-Of $polished)) '保留各自正文，不用相同文件伪造改稿'
}
$packages = @(Get-ChildItem -LiteralPath (Join-Path $root 'packages') -Filter 'execution-*.md')
$active = @($packages | Where-Object { (Get-Content -LiteralPath $_.FullName -Raw).Contains('| 状态 | active |') })
Add-Check '当前active执行包为0' ($active.Count -eq 0) '范围结束，不生成空包'
foreach ($batch in @('B01','B02')) {
    foreach ($type in @('input','execution')) {
        $relative = "packages/$type-$batch-v1.md"
        $content = Get-Content -LiteralPath (Join-Path $root $relative) -Raw
        Add-Check "$type-$batch 已消费" ($content.Contains('| 状态 | consumed |')) $relative
    }
}
Add-Check '无B03或003正文文件' (@(Get-ChildItem -LiteralPath (Join-Path $root 'packages'),(Join-Path $root 'prose') -File | Where-Object { $_.Name -match 'B03|^003' }).Count -eq 0) '只检查文件，不用禁词扫描判断剧情'
$log = Get-Content -LiteralPath (Join-Path $root 'RUN_LOG.md') -Raw
$last = -1
$ordered = $true
foreach ($stage in @('S01：','S02：','S03：','S04：','S05：','S06：','S07a：','S07b：','S08：','S09：','S10：','S11：','S12：','S13：')) {
    $at = $log.IndexOf($stage)
    if ($at -lt 0 -or $at -le $last) { $ordered = $false }
    $last = $at
}
Add-Check '真实运行记录阶段顺序' $ordered '记录与阶段哈希互相辅助，不能证明上下文隔离'
$activeProof = Get-Content -LiteralPath (Join-Path $root 'evidence/stages/S08-B02-active.json') -Raw | ConvertFrom-Json
Add-Check 'B02开写前唯一active证据' (($activeProof.active -eq 'execution-B02-v1.md') -and ($activeProof.written002 -eq $false)) 'S08保存于S09之前'
# 本轮实际发现总进度滞后；终态需同时看逐章接收和当前事实入口。
function Test-FinalProgress([string]$Content) {
    ($Content -match '(?m)^\| 001 \| 已接受') -and
    ($Content -match '(?m)^\| 002 \| 已接受') -and
    $Content.Contains('state/accepted-v2.md')
}
$progress = Get-Content -LiteralPath (Join-Path $root 'PROJECT_PROGRESS.md') -Raw
$staleProgress = Get-Content -LiteralPath (Join-Path $root 'history/initial-handoff/PROJECT_PROGRESS.md') -Raw
$entry = Get-Content -LiteralPath (Join-Path $root '00-CURRENT.md') -Raw
Add-Check '当前总进度逐章接受与最终基线一致' (Test-FinalProgress $progress) '001和002已接受；accepted-v2'
Add-Check '反例：旧0章进度不得通过终态门' (-not (Test-FinalProgress $staleProgress)) '使用保留的真实初始进度，不修改当前项目'
Add-Check '当前入口与最终事实及结束状态一致' ($entry.Contains('state/accepted-v2.md') -and $entry.Contains('当前active执行包：无')) '不以阶段日志代替当前入口'
foreach ($relative in @('reviews/B01-cycle.md','reviews/B02-cycle.md','reviews/B02-handoff.md','reviews/final-closeout.md','state/accepted-v1.md','state/accepted-v2.md','planning-v2.md')) {
    Add-Check "当前证据可读：$relative" ((Get-Item -LiteralPath (Join-Path $root $relative)).Length -gt 0) '存在非空不代表语义通过；见报告正文'
}
foreach ($relative in @('README.md','00-CURRENT.md')) {
    $content = Get-Content -LiteralPath (Join-Path $root $relative) -Raw
    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value
        Add-Check "当前入口链接：$target" (Test-Path -LiteralPath (Join-Path $root $target) -PathType Leaf) $relative
    }
}
$failed = @($checks | Where-Object { -not $_.passed })
$result = [ordered]@{
    generated_at=(Get-Date -Format o)
    root=$root
    scope='两章小样持久化、版本与生命周期；不替代语义审查'
    checks=$checks.Count
    failed=$failed.Count
    semantic_evidence=@('reviews/B01-cycle.md','reviews/B02-cycle.md','reviews/final-closeout.md')
    limitations=@('同一代理local四阶段','最初提前读到润色段，不证明上下文隔离','本轮无正文错误修复分支','旧verification.json是首包历史证据')
    results=@($checks)
}
$output = Join-Path $root 'evidence/prose-verification.json'
$result | ConvertTo-Json -Depth 7 | Set-Content -LiteralPath $output -Encoding utf8
[pscustomobject]@{ checks=$checks.Count; failed=$failed.Count; output=$output } | Format-List
if ($failed.Count -gt 0) { $failed | Format-Table -AutoSize; exit 1 }
