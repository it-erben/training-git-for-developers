. ..\utils\make-exercise-repo.ps1

$testScriptBash = @"
#! /usr/bin/env bash
if [[ `$(( `$(find * | wc -l) + 10 )) -gt 32 ]] ;then
  echo "test failed"
  exit 1
else
  echo "test passed"
  exit 0
fi
"@

$testScriptPs1 = @'
$fileCount = (Get-ChildItem -File | Measure-Object).Count
if (($fileCount + 10) -gt 32) {
    Write-Host "test failed"
    exit 1
} else {
    Write-Host "test passed"
    exit 0
}
'@

Set-Content "test.sh" $testScriptBash
Set-Content "test.ps1" $testScriptPs1
if (Get-Command chmod -ErrorAction SilentlyContinue) {
    chmod +x "test.sh"
}
git add "test.sh" "test.ps1"
git commit -m "Add tests"
git tag initial-commit

(1..100) | ForEach-Object {
  Out-File "$_.txt"
  git add .
  git commit -m "$_"
}
