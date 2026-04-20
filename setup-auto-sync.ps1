$repoPath = "C:\Users\user\Documents\GitHub\ai-second-brain"
$scriptPath = "$repoPath\auto-sync.ps1"
$taskName = "AI知識庫自動同步"

Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$scriptPath`""

$trigger = New-ScheduledTaskTrigger -AtLogOn

$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -Force

$task = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($task) {
    Write-Host "排程設定完成！每次登入後自動同步，也可手動執行 auto-sync.ps1" -ForegroundColor Green
    Set-ScheduledTask -TaskName $taskName -Trigger (New-ScheduledTaskTrigger -RepetitionInterval (New-TimeSpan -Minutes 5) -Once -At (Get-Date)) -ErrorAction SilentlyContinue
} else {
    Write-Host "排程設定失敗，請改用手動方式" -ForegroundColor Red
}

Write-Host "正在執行第一次同步..." -ForegroundColor Yellow
Set-Location $repoPath
git pull origin
Write-Host "完成。" -ForegroundColor Green
