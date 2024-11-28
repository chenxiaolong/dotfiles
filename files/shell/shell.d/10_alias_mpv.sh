if command -v mpv >/dev/null; then
    alias_if_missing mpvhdr 'ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=waylandvk'
fi
