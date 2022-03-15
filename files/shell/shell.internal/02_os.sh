if [[ -z "${__os:-}" ]]; then
    case "$(uname -r)" in
    *Microsoft*|*microsoft*)
        __os=WSL
        ;;
    esac
fi

if [[ -z "${__os:-}" ]]; then
    case "$(uname -s)" in
    Linux)
        __os=Linux
        ;;
    Darwin)
        __os=macOS
        ;;
    MINGW*|MSYS*)
        __os=Windows
        ;;
    *)
        __os=Unknown
        ;;
    esac
fi

is_os() {
    [[ "${__os}" == "${1}" ]]
}
