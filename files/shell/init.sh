# Written by: Andrew Gunnerson <andrewgunnerson@gmail.com>

__config_current_shell=
__config_dotfiles_dir=
__config_script_dir=

detect_shell() {
    if [[ -n "${ZSH_NAME}" ]]; then
        __config_current_shell="zsh"
    elif [[ -n "${BASH}" ]]; then
        __config_current_shell="bash"
    else
        echo "Unknown shell!" >&2
        return 1
    fi
}

is_shell() {
    [ "x${__config_current_shell}" = "x${1}" ]
}

detect_shell

if is_shell bash; then
    __config_script_dir=$(dirname "${BASH_SOURCE[0]}")
elif is_shell zsh; then
    __config_script_dir=$(dirname "${0}")
fi

if [[ -n "${__config_script_dir}" ]]; then
    __config_dotfiles_dir=${__config_script_dir}/../..
fi

for i in "${__config_script_dir}"/shell.internal/*.sh; do
    source "${i}"
done
for i in "${__config_script_dir}"/shell.d/*.sh; do
    source "${i}"
done
if [[ -d "${__config_script_dir}"/shell.local ]]; then
    for i in "${__config_script_dir}"/shell.local/*.sh; do
        source "${i}"
    done
fi
unset i

export DOTFILES=${__config_dotfiles_dir}

unset __config_dotfiles_dir
unset __config_script_dir
