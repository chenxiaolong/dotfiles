if [[ -n "${ANDROID_HOME}" ]]; then
    if [[ ! -d "${ANDROID_HOME}" ]]; then
        echo >&2 "WARNING: Android SDK path ${ANDROID_HOME} does not exist"
        return 1
    fi

    path_push_front "${ANDROID_HOME}/tools"
    path_push_front "${ANDROID_HOME}/tools/bin"
    path_push_front "${ANDROID_HOME}/platform-tools"

    if [[ -d "${ANDROID_HOME}/build-tools" ]]; then
        path_push_front "$(find "${ANDROID_HOME}/build-tools" \
                           -mindepth 1 -maxdepth 1 -print0 \
                           | sort -zV | tail -zn1 | tr -d '\0')"
    fi

    if [[ -d "${ANDROID_HOME}/cmdline-tools" ]]; then
        path_push_front "${ANDROID_HOME}/cmdline-tools/latest/bin"
    fi

    if [[ -z "${ANDROID_NDK_ROOT}" ]]; then
        export ANDROID_NDK_ROOT=$(find "${ANDROID_HOME}/ndk" \
                                  -mindepth 1 -maxdepth 1 ! \
                                  -name magisk -print0 \
                                  | sort -zV | tail -zn1 | tr -d '\0')

        if [[ -d "${ANDROID_NDK_ROOT}" ]]; then
            path_push_front "${ANDROID_NDK_ROOT}"
        else
            unset ANDROID_NDK_ROOT
        fi
    fi
fi
