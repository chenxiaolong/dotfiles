if is_os WSL; then
    win_echo() {
        (
            cd /mnt/c
            cmd.exe /c echo "${@}" | sed 's/\r$//g'
        )
    }
fi
