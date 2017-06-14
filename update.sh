#!/bin/bash

#######################################
# Globals
#######################################

TMP_FOLDER=
CONFIG_SUB_LOCS=
CONFIG_GUESS_LOCS=

# Get the most recent versions of config.guess and config.sub
function get_updated_files {
    TMP_FOLDER=`mktemp -d`
    
    wget -O ${TMP_FOLDER}/config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD'
    wget -O ${TMP_FOLDER}/config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD'
}

function find_config_files {
    CONFIG_SUB_LOCS=`find $1 -name "config.sub"`
    CONFIG_GUESS_LOCS=`find $1 -name "config.guess"`
}

function update_config_files {
    echo "Updating config.sub..."
    for file in ${CONFIG_SUB_LOCS[@]}; do
        cp ${TMP_FOLDER}/config.sub ${file}
    done

    echo "Updating config.guess..."
    for file in ${CONFIG_GUESS_LOCS[@]}; do
        cp ${TMP_FOLDER}/config.guess ${file}
    done
}

#######################################
# MAIN
#######################################

get_updated_files
find_config_files $1
update_config_files



