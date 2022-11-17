#!/bin/bash

set -euo pipefail

cols=$(tput cols)


readlink_f() {
  if [ $(uname) = 'Darwin' ]
  then
    local d=$(echo "${1%/*}")
    local f=$(basename "$1")
    (cd "$d" && echo "$(pwd -P)/$f")
  else
    readlink -f "$1"
  fi
}


addattr() {
  ext="$1"

  if ! grep -qE "^\*.$ext diff=image\$" "$attributesfile"
  then
    if grep -qE "^\*.$ext" "$attributesfile"
    then
      fold -s -w$cols >&2 <<EOS
$attributesfile already has *.$ext configured, but not the way that this script requires.

If you want to use git-image-diff with $ext files, you must add a diff=image attribute yourself.


EOS
    else
      echo "+ echo '*.$ext diff=image' >>'$attributesfile'"
      echo "*.$ext diff=image" >>"$attributesfile"
    fi
  fi
}


thisdir=$(dirname $(readlink_f "$0"))
thisdir_tilde="${thisdir/#$HOME/~}"

attributesfile_tilde=$(git config --global core.attributesfile || true)
attributesfile="${attributesfile_tilde/#\~/$HOME}"
if [ -z "$attributesfile" ]
then
  attributesfile="$HOME/.gitattributes"
  attributesfile_tilde="~/.gitattributes"
  echo "+ git config --global core.attributesfile '$attributesfile_tilde'"
  git config --global core.attributesfile "$attributesfile_tilde"
fi

if [ ! -f "$attributesfile" ]
then
  if [ ! -e "$attributesfile" ]
  then
    echo "+ touch '$attributesfile'"
    touch "$attributesfile"
  else
    echo "$attributesfile is not a regular file!  I give up." >&2
    exit 1
  fi
fi

addattr bmp
addattr gif
addattr heic
addattr jpeg
addattr jpg
addattr png
addattr svg

echo '+ git config --global alias.diff-image '"'"'!f() { cd -- "${GIT_PREFIX:-.}"; GIT_DIFF_IMAGE_ENABLED=1 git diff "$@"; }; f'"'"
git config --global alias.diff-image '!f() { cd -- "${GIT_PREFIX:-.}"; GIT_DIFF_IMAGE_ENABLED=1 git diff "$@"; }; f'

echo "+ git config --global diff.image.command '$thisdir_tilde/git_diff_image'"
git config --global diff.image.command "$thisdir_tilde/git_diff_image"

bin_diff_image_tilde="~/bin/diff-image"
bin_diff_image="${bin_diff_image_tilde/#\~/$HOME}"
if [ -e "$bin_diff_image" ]
then
    echo "# Leaving $bin_diff_image alone."
else
    if [ ! -d "$HOME/bin" ]
    then
        echo "+ mkdir -p ~/bin"
        mkdir -p "$HOME/bin"
    fi

    echo "+ ln -s $thisdir_tilde/diff-image ~/bin/"
    ln -s "$thisdir/diff-image" "$HOME/bin/"
fi
