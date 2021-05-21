#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/microsoft/vscode-dev-containers/blob/master/script-library/docs/go.md
# Maintainer: The VS Code and Codespaces Teams
#
# Syntax: ./go-debian.sh [Go version] [GOROOT] [GOPATH] [non-root user] [Add GOPATH, GOROOT to rc files flag] [Install tools flag]

TARGET_GOROOT=${1:-"/usr/local/go"}
TARGET_GOPATH=${2:-"/go"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

function updaterc() {
    echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
    echo -e "$1" >> /etc/bash.bashrc
}

# Install Go tools that are isImportant && !replacedByGopls based on
# https://github.com/golang/vscode-go/blob/0c6dce4a96978f61b022892c1376fe3a00c27677/src/goTools.ts#L188
# exception: golangci-lint is installed using their install script below.
GO_TOOLS="\
    golang.org/x/tools/gopls \
    honnef.co/go/tools/... \
    golang.org/x/lint/golint \
    github.com/mgechev/revive \
    github.com/uudashr/gopkgs/v2/cmd/gopkgs \
    github.com/ramya-rao-a/go-outline \
    github.com/go-delve/delve/cmd/dlv "

echo "Installing common Go tools..."
export PATH=${TARGET_GOROOT}/bin:${PATH}
mkdir -p /tmp/gotools /usr/local/etc/vscode-dev-containers ${TARGET_GOPATH}/bin
cd /tmp/gotools
export GOPATH=/tmp/gotools
export GOCACHE=/tmp/gotools/cache

# Go tools w/module support
export GO111MODULE=on
(echo "${GO_TOOLS}" | xargs -n 1 go get -v )2>&1 | tee -a /usr/local/etc/vscode-dev-containers/go.log

# Move Go tools into path and clean up
mv /tmp/gotools/bin/* ${TARGET_GOPATH}/bin/
rm -rf /tmp/gotools

# Add GOPATH variable and bin directory into PATH in bashrc/zshrc files (unless disabled)
updaterc "$(cat << EOF
export GOPATH="${TARGET_GOPATH}"
if [[ "\${PATH}" != *"\${GOPATH}/bin"* ]]; then export PATH="\${PATH}:\${GOPATH}/bin"; fi
export GOROOT="${TARGET_GOROOT}"
if [[ "\${PATH}" != *"\${GOROOT}/bin"* ]]; then export PATH="\${PATH}:\${GOROOT}/bin"; fi
EOF
)"

echo "Done!"
