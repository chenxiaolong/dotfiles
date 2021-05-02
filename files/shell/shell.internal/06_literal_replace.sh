literal_replace() {
    source=${1} \
    target=${2} \
    perl -pe 's/\Q$ENV{source}\E/$ENV{target}/g'
}
