if is_os macOS; then
    alias rfc3339="gdate --rfc-3339=seconds | sed 's/ /T/'"
else
    alias rfc3339="date --rfc-3339=seconds | sed 's/ /T/'"
fi
