#!/bin/bash

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[@]}")"

if [[ "${#}" -eq 0 ]]; then
    echo >&2 "Usage: ${0} <vscode executable>"
    exit 1
fi

cmd=${1}

while read -r line; do
    "${cmd}" --install-extension "${line}"
done < extensions.txt
