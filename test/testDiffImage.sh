#!/bin/zsh
set -eo pipefail # automatic. fails on any error

OS="`uname`"
case $OS in
  'Linux')
    echo "Fix display on Linux"
    export DISPLAY=:99
    sudo Xvfb -ac :99 -screen 0 1280x1024x24 > /dev/null 2>&1 &
    ;;
  'FreeBSD')
    ;;
  'WindowsNT')
    ;;
  'Darwin')
    #brew install jq | echo "Nothing to do with brew"
    ;;
  'SunOS')
    ;;
  'AIX') ;;
  *) ;;
esac

diffFiles=./screenshotDiffs
mkdir $diffFiles
GIT_DIFF_IMAGE_OUTPUT_DIR=$diffFiles git diff-image

pwd
source $(dirname $0)/lib.sh

echo "GITHUB_REF_NAME=$GITHUB_REF_NAME"
echo $(echo "$GITHUB_REF_NAME" | sed "s/\// /")
PR=$(echo "$GITHUB_REF_NAME" | sed "s/\// /" | awk '{print $1}')
echo "PR=$PR GITHUB_REF_NAME=$GITHUB_REF_NAME"

# set error when diffs are there
echo ""
[ "$(ls -A $diffFiles)" ] && echo "==> Diff files exists as expected" && exit 0 || echo "==> Diff files doesn't exist" && exit 1
