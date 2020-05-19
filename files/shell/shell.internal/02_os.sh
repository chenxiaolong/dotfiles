if [[ -z "${__os}" ]]; then
    case "$(uname -r)" in
    *Microsoft*|*microsoft*)
        __os=WSL
        ;;
    esac
fi

if [[ -z "${__os}" ]]; then
    case "$(uname -s)" in
    Linux)
        __os=Linux
        ;;
    Darwin)
        __os=macOS
        ;;
    *)
        __os=Unknown
        ;;
    esac
fi

is_os() {
    local i
    for i in "${@}"; do
        if [[ "${__os}" == "${i}" ]]; then
            return 0
        fi
    done
    return 1
}
