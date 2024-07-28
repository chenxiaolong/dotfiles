if is_shell bash && [[ ${BLE_VERSION-} ]]; then
    ble-attach
    #ble/debug/profiler/stop
fi
