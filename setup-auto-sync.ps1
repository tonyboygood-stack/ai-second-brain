# 一鍵安裝自動同步排程
# 請用「以系統管理員身分執行」開啟 PowerShell 後執行此腳本

$repoPath = "C:\Users\user\Documents\GitHub\ai-second-brain"
$scriptPath = "$repoPath\auto-sync.ps1"
$taskName = "AI知識庫自動同步"

# 移除舊排程（若存在）
Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue

# 設定執行動作
$action = New-ScheduledTaskAction `
    -Execute "powershell.exe" `
    -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""

# 設定觸發條件：登入後立刻執行，之後每 5 分鐘重複
$trigger = New-ScheduledTaskTrigger -AtLogOn
$trigger.RepetitionInterval = (New-TimeSpan -Minutes 5)
$trigger.RepetitionDuration = ([TimeSpan]::MaxValue)

# 設定執行設定
$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -RunOnlyIfNetworkAvailable

# 註冊排程工作
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -RunLevel Highest `
    -Force

Write-Host ""
Write-Host "✓ 排程設定完成！" -ForegroundColor Green
Write-Host "  - 任務名稱：$taskName"
Write-Host "  - 執行時機：登入後自動啟動，每 5 分鐘同步一次"
Write-Host "  - 同步記錄：$repoPath\sync-log.txt"
Write-Host ""

# 立刻執行一次測試
Write-Host "正在執行第一次同步..." -ForegroundColor Yellow
& $scriptPath
Write-Host "完成。" -ForegroundColor Green
