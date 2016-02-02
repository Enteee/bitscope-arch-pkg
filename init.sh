#!/bin/bash
#=== Variable ===s
# Configuration
VARIABLE_INDICATOR="__"
INPUT_STRING_LEN=15
OUTPUT_VARNAME_LEN=15
OUTPUT_STRING_LEN=20

#Used files/directories
DIR_CALLDIR="$(pwd)"
DIR_TOPLEVEL="${1}"

#Metadata
VARIABLE_DECLARATION=""

#Intial tools
INIT_TOOLS="${DIR_TOPLEVEL}/tools/"
AWESOMEREPLACE="${INIT_TOOLS}/awesomereplace"
SPONGE="${INIT_TOOLS}/sponge"

#=== Functions ===
function newlineIFS(){
    OLDIFS="${IFS}"
    IFS=$'\n'
}

function semicolonIFS(){
    OLDIFS="${IFS}"
    IFS=';'
}

function restoreIFS(){
    IFS="${OLDIFS}"
}

function inputFixedString(){
    local readstring=""
    while [ "${readstring}" == "" ]; do
        read -r readstring
    done
    printf "%${INPUT_STRING_LEN}.${INPUT_STRING_LEN}s" "${readstring}"
}

function printVars(){
    semicolonIFS
    for varname in ${VARIABLE_DECLARATION}; do
        local varplaceholder="${VARIABLE_INDICATOR}${varname}${VARIABLE_INDICATOR}"
        local vardata="${!varname}"
        printf "%${OUTPUT_VARNAME_LEN}.${OUTPUT_VARNAME_LEN}s : %${OUTPUT_VARNAME_LEN}.${OUTPUT_VARNAME_LEN}s : %s\n" "${varname}" "${varplaceholder}" "${vardata}"
    done
    restoreIFS
}

function defineVars(){
    echo "=== Load variabels ==="
    newlineIFS
    VARIABLE_DECLARATION=""
    for var in $(set); do
        varname=$(echo "${var}" | sed -nre 's/^([a-zA-Z0-9]+)\=.+$/\1/p')
        if [ "${varname}" != "" ]; then
            VARIABLE_DECLARATION="${varname};${VARIABLE_DECLARATION}"
        fi
    done
    restoreIFS

    echo "=== Variables ==="
    printVars
}

function replaceVars(){
    local file="${1}"
    if [ -f "${file}" ]; then
        semicolonIFS
        for varname in ${VARIABLE_DECLARATION}; do
            local varplaceholder="${VARIABLE_INDICATOR}${varname}${VARIABLE_INDICATOR}"
            local vardata="${!varname}"
            cat "${file}" | "${AWESOMEREPLACE}" "${varplaceholder}" "${vardata}" | "${SPONGE}" "${file}"
        done
        restoreIFS
    fi
}
