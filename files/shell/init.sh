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
    [[ "${__config_current_shell}" == "${1}" ]]
}

detect_shell

__config_script_dir=$(dirname "${BASH_SOURCE[0]:-${(%):-%x}}")

if [[ -n "${__config_script_dir}" ]]; then
    __config_dotfiles_dir=${__config_script_dir}/../..
fi

for i in "${__config_script_dir}"/shell.{internal,d}/*.sh; do
    source "${i}"
done
unset i

export DOTFILES=${__config_dotfiles_dir}

unset __config_dotfiles_dir
unset __config_script_dir
