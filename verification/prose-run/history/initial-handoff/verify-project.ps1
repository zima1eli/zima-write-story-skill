param(
    [ValidateSet('draft', 'active')][string]$ExpectedStatus = 'active',
    [string]$EvidenceFile = 'verification.json'
)

$ErrorActionPreference = 'Stop'
$projectRoot = $PSScriptRoot
$checks = [System.Collections.Generic.List[object]]::new()
function Record-Check([string]$Name, [bool]$Passed, [string]$Detail) {
    $checks.Add([pscustomobject]@{ name = $Name; passed = $Passed; detail = $Detail })
}
function Read-Project([string]$RelativePath) {
    return Get-Content -LiteralPath (Join-Path $projectRoot $RelativePath) -Raw -Encoding UTF8
}

$required = @('README.md', '00-CURRENT.md', 'book-config.md', 'planning.md', 'state.md', 'PROJECT_PROGRESS.md', 'sources/outline.md', 'packages/input-B01-v1.md', 'packages/execution-B01-v1.md', 'reviews/planning-review-v1.md', 'reviews/handoff-acceptance-v1.md', 'evidence/source-manifest.json')
foreach ($relative in $required) {
    Record-Check "文件存在: $relative" (Test-Path -LiteralPath (Join-Path $projectRoot $relative) -PathType Leaf) $relative
}
$manifest = (Read-Project 'evidence/source-manifest.json') | ConvertFrom-Json
$outlineEntry = @($manifest.sources | Where-Object { $_.role -eq 'user_outline' })[0]
$copiedHash = (Get-FileHash -LiteralPath (Join-Path $projectRoot 'sources/outline.md') -Algorithm SHA256).Hash
Record-Check '原大纲逐字节副本' ($copiedHash -eq $outlineEntry.sha256) $copiedHash

$inputText = Read-Project 'packages/input-B01-v1.md'
$executionText = Read-Project 'packages/execution-B01-v1.md'
foreach ($package in @(@{ name = 'input'; text = $inputText }, @{ name = 'execution'; text = $executionText })) {
    foreach ($token in @('rain-before-stop', 'outline-v1', 'planning-v1', 'initial-v1', 'style-v1', '生成者', '验收者与证据')) {
        Record-Check "$($package.name)版本字段: $token" ($package.text.Contains($token)) $token
    }
    Record-Check "$($package.name)仅首章范围" ($package.text.Contains('| 章节范围 | 001；用户总范围001—002')) 'B01=001，总目标=001—002'
    Record-Check "$($package.name)生命周期状态" ($package.text.Contains("| 状态 | $ExpectedStatus |")) $ExpectedStatus
}
Record-Check '执行包引用对应输入版本' ($executionText.Contains('input-B01-v1.md / input-B01-v1 / v1')) 'input-B01-v1'

$entryText = Read-Project '00-CURRENT.md'
$progressText = Read-Project 'PROJECT_PROGRESS.md'
Record-Check '当前入口指向唯一包且状态一致' ($entryText.Contains('packages/execution-B01-v1.md') -and $entryText.Contains("状态：``$ExpectedStatus``")) $ExpectedStatus
Record-Check '进度保留两章总范围与首章批次' ($progressText.Contains('故事总范围：001—002；当前批次B01仅001')) '范围记录'
$activeExecutions = @(Get-ChildItem -LiteralPath (Join-Path $projectRoot 'packages') -Filter 'execution*.md' | Where-Object { (Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8).Contains('| 状态 | active |') })
$expectedCount = if ($ExpectedStatus -eq 'active') { 1 } else { 0 }
Record-Check 'active执行包数量' ($activeExecutions.Count -eq $expectedCount) "actual=$($activeExecutions.Count), expected=$expectedCount"

$planningText = Read-Project 'planning.md'
Record-Check '两章施工图段落均可定位' ($planningText.Contains('## 第001章：') -and $planningText.Contains('## 第002章：')) '仅结构定位；语义深度由规划审查承担'
Record-Check '逐章材料与技法段落' (([regex]::Matches($planningText, '### 可写材料层').Count -eq 2) -and ([regex]::Matches($planningText, '### 正文扩写技法').Count -eq 2)) '两章各有材料与技法段落；不据数量判断内容质量'
Record-Check '初始状态明示无接受正文' ((Read-Project 'state.md').Contains('正文接受范围：无')) '未把未来终态写成实绩'
Record-Check 'B02未提前生成' (-not (Test-Path -LiteralPath (Join-Path $projectRoot 'packages/execution-B02-v1.md'))) '续批需首章接受与实绩入账'

$missingLinks = [System.Collections.Generic.List[string]]::new()
foreach ($file in Get-ChildItem -LiteralPath $projectRoot -Filter '*.md' -Recurse) {
    $content = Get-Content -LiteralPath $file.FullName -Raw -Encoding UTF8
    foreach ($match in [regex]::Matches($content, '\[[^\]]*\]\(([^)]+)\)')) {
        $target = $match.Groups[1].Value.Split('#')[0]
        if ($target -match '^(https?://|#)' -or [string]::IsNullOrWhiteSpace($target)) { continue }
        $resolved = [System.IO.Path]::GetFullPath((Join-Path $file.DirectoryName $target))
        if (-not (Test-Path -LiteralPath $resolved)) { $missingLinks.Add("$($file.Name): $target") }
    }
}
Record-Check '项目Markdown链接可定位' ($missingLinks.Count -eq 0) ($missingLinks -join '; ')

$failed = @($checks | Where-Object { -not $_.passed })
$result = [pscustomobject]@{
    checked_at = (Get-Date).ToString('o')
    book_id = 'rain-before-stop'
    total_planning_scope = @('001', '002')
    batch = 'B01'
    execution_scope = @('001')
    expected_status = $ExpectedStatus
    check_count = $checks.Count
    failed_count = $failed.Count
    checks = $checks
    semantic_evidence = 'reviews/planning-review-v1.md'
    limitations = @('机械校验不证明小说正文质量', '没有正文实写或独立下游验收', '语义审查由本轮执行代理完成')
}
$result | ConvertTo-Json -Depth 8 | Set-Content -LiteralPath (Join-Path $projectRoot "evidence/$EvidenceFile") -Encoding UTF8
$result | Select-Object book_id, batch, execution_scope, expected_status, check_count, failed_count | ConvertTo-Json -Depth 4
if ($failed.Count -gt 0) { $failed | ConvertTo-Json -Depth 4; exit 1 }
