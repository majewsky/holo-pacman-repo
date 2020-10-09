#!/bin/bash
set -euo pipefail
cd "$(readlink -f "$(dirname "$0")")"

if [ $# -eq 0 ]; then
  echo "Call as: $0 <subdirectory>..." >&2
  exit 1
fi

for TARGET_DIR in "$@"; do
  mkdir -p "${TARGET_DIR}"
  SOURCE_DIR=".vendor-cache/${TARGET_DIR}"

  if [ -d "${SOURCE_DIR}" ]; then
    git -C "${SOURCE_DIR}" remote update origin
  else
    git clone "https://aur.archlinux.org/${TARGET_DIR}.git" "${SOURCE_DIR}"
  fi

  git clean -dXf "${TARGET_DIR}"
  git ls-files -- "${TARGET_DIR}" | xargs -r rm
  git -C "${SOURCE_DIR}" archive --prefix="${TARGET_DIR}/" origin/master | tar xf -
done
