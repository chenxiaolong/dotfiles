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
fi

# gpg
if command -v gpg >/dev/null; then
    new_dotfile_symlink ~/.gnupg/gpg-agent.conf files/gnupg/gpg-agent.conf
fi

# Mercurial
if command -v hg >/dev/null; then
    new_dotfile_symlink ~/.hgrc files/hgrc
fi

# rg
if command -v rg >/dev/null; then
    new_dotfile_symlink ~/.ripgreprc files/ripgreprc
fi

# nvim
if command -v nvim >/dev/null; then
    new_dotfile_symlink ~/.config/nvim files/nvim
fi

# starship
if command -v starship >/dev/null; then
    new_dotfile_symlink ~/.config/starship.toml files/starship.toml
fi

# tmux
if command -v tmux >/dev/null; then
    new_dotfile_symlink ~/.tmux files/tmux
    new_dotfile_symlink ~/.tmux.conf files/tmux.conf
fi

# X11
if command -v xrdb; then
    new_dotfile_symlink ~/.Xresources files/Xresources
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

# Arch Linux
if [[ -f /etc/arch-release ]]; then
    # makepkg
    new_dotfile_symlink ~/.makepkg.conf files/makepkg.conf

    # pinentry
    new_dotfile_symlink ~/.config/pinentry files/pinentry
fi

# yt-dlp
if command -v yt-dlp >/dev/null; then
    new_dotfile_symlink ~/.config/yt-dlp/config files/yt-dlp/config
fi

# foot
if command -v foot >/dev/null; then
    new_dotfile_symlink ~/.config/foot files/foot
fi

# alacritty
if command -v alacritty >/dev/null; then
    new_dotfile_symlink ~/.config/alacritty files/alacritty
fi

# wezterm
if command -v wezterm >/dev/null; then
    new_dotfile_symlink ~/.config/wezterm files/wezterm
fi

# kitty
if command -v kitty >/dev/null; then
    new_dotfile_symlink ~/.config/kitty files/kitty
fi
