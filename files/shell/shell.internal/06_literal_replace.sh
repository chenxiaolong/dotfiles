literal_replace() {
    source=${1} \
    target=${2} \
    perl -pe 'BEGIN{undef $/;} s/\Q$ENV{source}\E/$ENV{target}/smg'
}
