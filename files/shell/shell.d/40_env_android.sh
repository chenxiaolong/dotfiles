set_up_android_sdk() {
    local sdk_path

    if [[ -n "${ANDROID_HOME}" ]]; then
        sdk_path=${ANDROID_HOME}
    elif [[ -d /opt/android-sdk ]]; then
        sdk_path=/opt/android-sdk
    fi

    if [[ -n "${sdk_path}" ]]; then
        if [[ ! -d "${sdk_path}" ]]; then
            echo >&2 "WARNING: Android SDK path ${sdk_path} does not exist"
            return 1
        fi

        export ANDROID_HOME=${sdk_path}

        path_push_front "${sdk_path}/tools"
        path_push_front "${sdk_path}/tools/bin"
        path_push_front "${sdk_path}/platform-tools"

        if [[ -d "${sdk_path}/build-tools" ]]; then
            path_push_front "$(find "${sdk_path}/build-tools" \
                               -mindepth 1 -maxdepth 1 -print0 \
                               | sort -zV | tail -zn1 | tr -d '\0')"
        fi
    fi
}

set_up_android_ndk() {
    local ndk_path

    if [[ -n "${ANDROID_NDK_ROOT}" ]]; then
        ndk_path=${ANDROID_NDK_ROOT}
    elif [[ -n "${ANDROID_HOME}" && -d "${ANDROID_HOME}/ndk" ]]; then
        ndk_path=$(find "${ANDROID_HOME}/ndk" \
                   -mindepth 1 -maxdepth 1 ! -name magisk -print0 \
                   | sort -zV | tail -zn1 | tr -d '\0')
    elif [[ -d /opt/android-ndk ]]; then
        ndk_path=/opt/android-ndk
    fi

    if [[ -n "${ndk_path}" ]]; then
        if [[ ! -d "${ndk_path}" ]]; then
            echo >&2 "WARNING: Android NDK path ${ndk_path} does not exist"
            return 1
        fi

        export ANDROID_NDK_ROOT=${ndk_path}
        path_push_front "${ndk_path}"
    fi
}

set_up_android_sdk
set_up_android_ndk

unset -f set_up_android_sdk
unset -f set_up_android_ndk
