#!/usr/bin/env bash
# -*- mode: sh; coding: utf-8; fill-column: 80; -*-
#
# build-site.sh
#

# ```````````````````````````````````````````````````
# ** Configuration **
#

# The following are list of files that we do not want in the deployed Website,
# for instance, this shell script.
readonly SELF=`basename "$0"`
readonly EXCLUDES="${SELF} sync_web .envrc"


# Directory containing rendered Website.
readonly SITE_DIR='_site'

#
# ```````````````````````````````````````````````````
#


# __________________________________________________
# *** DO NOT EDIT THE CODE BELOW. ***
#

function _err() {
    echo "Error:" $1 >& 2
    exit ${FAIL}
}

function chk_bin() {
    local bin_name="$1"
    local bin_path=$(which ${bin_name})
    [[ -z ${bin_path} ]] &&
        _err "Missing binary (${bin_name})."
    [[ ! -f ${bin_path} ]] &&
        _err "Binary (${bin_path}) not found."
    [[ ! -x ${bin_path} ]] &&
        _err "Binary (${bin_path}) not executable."
    echo ${bin_path}
}


function remove_excludes() {
    for f in $EXCLUDES; do
        rm -f "${SITE_DIR}/$f"
    done
}


readonly BUNDLER="$(chk_bin bundle)"

$BUNDLER exec jekyll build &&
    remove_excludes &&
    echo 'Website is ready to deploy.'
