#!/bin/bash
source ../utils/utils.sh

pre-setup # Make exercise repo, and setup necessary.

echo '#! /usr/bin/env bash' > 'test.sh'
echo 'if [[ $(( $(find * | wc -l) + 10 )) -gt 32 ]] ;then' >> 'test.sh'
echo '  echo "test failed"' >> 'test.sh'
echo '  exit 1' >> 'test.sh'
echo 'else' >> 'test.sh'
echo '  echo "test passed"' >> 'test.sh'
echo '  exit 0' >> 'test.sh'
echo 'fi' >> 'test.sh'
chmod +x 'test.sh'

cat > 'test.ps1' << 'PSEOF'
$fileCount = (Get-ChildItem -File | Measure-Object).Count
if (($fileCount + 10) -gt 32) {
    Write-Host "test failed"
    exit 1
} else {
    Write-Host "test passed"
    exit 0
}
PSEOF

git add "test.sh" "test.ps1"
git commit -m "Add tests"
git tag initial-commit

for i in {1..100}
do
  touch "$i.txt"
  git add "$i.txt"
  git commit -m $i
done

post-setup