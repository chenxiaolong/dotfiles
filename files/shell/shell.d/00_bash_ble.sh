if is_shell bash && [[ $- == *i* ]]; then
    source "${__config_dotfiles_dir}/submodules/ble.sh/out/ble.sh" --noattach
    #ble/debug/profiler/start
fi
