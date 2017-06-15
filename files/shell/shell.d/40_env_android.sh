set_up_android_sdk() {
    local sdk_path
    local build_tools_ver

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

        path_push_back "${sdk_path}/tools"
        path_push_back "${sdk_path}/tools/bin"
        path_push_back "${sdk_path}/platform-tools"

        if [[ -d "${sdk_path}/build-tools" ]]; then
            build_tools_ver="$(find "${sdk_path}/build-tools" \
                               -mindepth 1 -maxdepth 1 \
                               | sort -V | tail -1)"
            build_tools_ver="$(basename "${build_tools_ver}")"
            path_push_back "${sdk_path}/build-tools/${build_tools_ver}"
        fi
    fi
}

set_up_android_ndk() {
    local ndk_path

    if [[ -n "${ANDROID_NDK}" ]]; then
        ndk_path=${ANDROID_NDK}
    elif [[ -n "${ANDROID_NDK_HOME}" ]]; then
        ndk_path=${ANDROID_NDK_HOME}
    elif [[ -d /opt/android-ndk ]]; then
        ndk_path=/opt/android-ndk
    fi

    if [[ -n "${ndk_path}" ]]; then
        if [[ ! -d "${ndk_path}" ]]; then
            echo >&2 "WARNING: Android NDK path ${ndk_path} does not exist"
            return 1
        fi

        export ANDROID_NDK=${ndk_path}
        export ANDROID_NDK_HOME=${ndk_path}
        path_push_back "${ndk_path}"
    fi
}

set_up_android_sdk
set_up_android_ndk

unset -f set_up_android_sdk
unset -f set_up_android_ndk
