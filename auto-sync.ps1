# 自動同步腳本
# 功能：自動從 GitHub 拉取最新的卡片與筆記

$repoPath = "C:\Users\user\Documents\GitHub\ai-second-brain"
$logFile = "$repoPath\sync-log.txt"

Set-Location $repoPath
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

try {
    $result = git pull origin 2>&1
    Add-Content $logFile "[$timestamp] 同步成功: $result"
} catch {
    Add-Content $logFile "[$timestamp] 同步失敗: $_"
}
