$repoPath = "C:\Users\user\Documents\GitHub\ai-second-brain"
$scriptPath = "$repoPath\auto-sync.ps1"
$taskName = "AI知識庫自動同步"

Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue

$argString = '-ExecutionPolicy Bypass -WindowStyle Hidden -File "' + $scriptPath + '"'
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument $argString

$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest -Force

Write-Host "排程設定完成！登入後自動同步。" -ForegroundColor Green
Write-Host "正在執行第一次同步..." -ForegroundColor Yellow
Set-Location $repoPath
git pull origin
Write-Host "完成。" -ForegroundColor Green
