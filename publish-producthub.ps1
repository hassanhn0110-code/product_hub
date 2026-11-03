# Run from your own PowerShell terminal to finish the authorized GitHub upload.
# Does not install software or force-push. GitHub may request sign-in.
$ErrorActionPreference = 'Stop'
Set-Location -LiteralPath $PSScriptRoot
$expectedRemote = 'https://github.com/hassanhn0110-code/product_hub.git'
if ((git remote get-url origin) -ne $expectedRemote) { throw 'Unexpected origin; stopping.' }
if ((git branch --show-current) -ne 'main') { throw 'Expected main branch; stopping.' }
npm.cmd run lint
if ($LASTEXITCODE -ne 0) { throw 'Lint failed.' }
npm.cmd run build
if ($LASTEXITCODE -ne 0) { throw 'Build failed.' }

# Stage only the application, documentation, and reviewed configuration.
git add -- .env.example .gitignore .npmrc AGENTS.md README.md backend check.md docs frontend/package.json frontend/package-lock.json frontend/vite.config.js frontend/.oxlintrc.json frontend/index.html frontend/src frontend/public publish-producthub.ps1
if ($LASTEXITCODE -ne 0) { throw 'Staging failed.' }
$stagedFiles = @(git diff --cached --name-only)
$credentialPatterns = @(
  '-----BEGIN (?:RSA |EC |OPENSSH |DSA )?PRIVATE KEY-----',
  '(?:gh[pousr]_[A-Za-z0-9]{20,}|github_pat_[A-Za-z0-9_]{20,})',
  '(?:AKIA|ASIA)[A-Z0-9]{16}',
  '\beyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}',
  '\b(?:sk_live_|sk_test_|sk-proj-|sb_secret_)[A-Za-z0-9_-]{12,}',
  '(?im)(?:password|passwd|api[_-]?key|access[_-]?token|auth[_-]?token|client[_-]?secret|service[_-]?role[_-]?key|_authToken)\s*[:=]\s*["'']?[^\s"''`]{8,}',
  '(?i)(?:postgres(?:ql)?|mysql|https?)://[^\s/:]+:[^\s/@]+@'
)
foreach ($file in $stagedFiles) {
  if ($file -match '(^|/)(node_modules|dist|\.verification|\.cache)(/|$)' -or ($file -match '(^|/)\.env' -and $file -ne '.env.example')) { throw "Excluded file staged: $file" }
  if ($file -match '\.png$') { continue }
  $stagedContent = (git show ":$file") -join "`n"
  foreach ($pattern in $credentialPatterns) {
    if ([regex]::IsMatch($stagedContent, $pattern)) { throw "Possible credential in $file; value withheld. Review before publishing." }
  }
}
git diff --cached --stat
git diff --cached --quiet
$diffExit = $LASTEXITCODE
if ($diffExit -eq 1) {
  git commit -m 'Publish ProductHub project and interactive product search'
  if ($LASTEXITCODE -ne 0) { throw 'Commit failed.' }
} elseif ($diffExit -ne 0) { throw 'Could not inspect staged changes.' }
git push -u origin main
if ($LASTEXITCODE -ne 0) { throw 'Push failed. Complete GitHub sign-in if requested, then run this helper again. Never paste credentials into chat.' }
$localSha = git rev-parse HEAD
$remoteLine = git ls-remote origin refs/heads/main
if ($LASTEXITCODE -ne 0 -or -not $remoteLine -or ($remoteLine -split '\s+')[0] -ne $localSha) { throw 'Could not verify remote main matches the local commit.' }
Write-Host "SUCCESS: origin/main verified at $localSha"
Write-Host 'Open https://github.com/hassanhn0110-code/product_hub'
Write-Host 'The agent checkpoint currently records the earlier blocked attempt; update it with the verified commit SHA after this succeeds.'
