#!/bin/bash

set -euo pipefail

new_dotfile_symlink() {
    local source=${1}
    local target=${2}
    local abs_target
    local link_target

    # macOS doesn't have readlink -f
    abs_target=$(pwd)/"${target}"

    mkdir -p "$(dirname "${source}")"

    if [[ -L "${source}" ]]; then
        link_target=$(readlink "${source}")
        if [[ "${link_target}" != "${abs_target}" ]]; then
            echo >&2 "${source}: path exists and is symlinked to ${link_target}"
            return 1
        fi

        echo "${source}: path already correctly linked"
        return
    elif [[ -e "${source}" ]]; then
        echo >&2 "${source}: path exists and is not a symlink"
        return 1
    fi

    echo "Symlinking ${source} to ${abs_target}"
    ln -sn "${abs_target}" "${source}"
}

cd "$(dirname "${BASH_SOURCE[0]}")"

# git
if command -v git >/dev/null; then
    new_dotfile_symlink ~/.gitconfig files/git/gitconfig
    new_dotfile_symlink ~/.gitconfig.delta files/git/gitconfig.delta
    if [[ "$(uname -r)" = *[Mm]icrosoft* ]]; then
        new_dotfile_symlink ~/.gitconfig.platform files/git/gitconfig.wsl
    fi
fi

# Mercurial
if command -v hg >/dev/null; then
    new_dotfile_symlink ~/.hgrc files/hgrc
fi

# rg
if command -v rg >/dev/null; then
    new_dotfile_symlink ~/.ripgreprc files/ripgreprc
fi

# emacs
if command -v emacs >/dev/null; then
    new_dotfile_symlink ~/.emacs files/emacs
fi

# vim
if command -v vim >/dev/null; then
    new_dotfile_symlink ~/.vim files/vim
    new_dotfile_symlink ~/.vimrc files/vim/vimrc
fi
# nvim
if command -v nvim >/dev/null; then
    new_dotfile_symlink ~/.config/nvim files/vim
fi

# starship
if command -v starship >/dev/null; then
    new_dotfile_symlink ~/.config/starship.toml files/starship.toml
fi

# vscode
if [[ "$(uname -s)" == Darwin ]]; then
    vscode_dirs=(~/Library/Application\ Support/Code/User)
else
    vscode_dirs=()
    if command -v flatpak >/dev/null && flatpak info com.visualstudio.code &>/dev/null; then
        vscode_dirs+=(~/.var/app/com.visualstudio.code/config/Code/User)
    fi
    if command -v code >/dev/null; then
        vscode_dirs+=(~/.config/Code/User)
    fi
    if command -v code-oss >/dev/null; then
        vscode_dirs+=(~/.config/'Code - OSS'/User)
    fi
fi
for vscode_dir in "${vscode_dirs[@]}"; do
    new_dotfile_symlink "${vscode_dir}"/keybindings.json files/vscode/keybindings.json
    new_dotfile_symlink "${vscode_dir}"/settings.json files/vscode/settings.json
done

# tmux
if command -v tmux >/dev/null; then
    new_dotfile_symlink ~/.tmux files/tmux
    new_dotfile_symlink ~/.tmux.conf files/tmux.conf
fi

# X11
if [[ "$(uname -r)" != *[Mm]icrosoft* ]]; then
    new_dotfile_symlink ~/.Xresources files/Xresources
fi

# makepkg
if [[ -f /etc/arch-release ]]; then
    new_dotfile_symlink ~/.makepkg.conf files/makepkg.conf
fi

# bat
if command -v bat >/dev/null; then
    new_dotfile_symlink "$(bat --config-dir)" files/bat
    bat cache --build
fi

# mock
if command -v mock >/dev/null; then
    new_dotfile_symlink ~/.config/mock.cfg files/mock.cfg
fi
