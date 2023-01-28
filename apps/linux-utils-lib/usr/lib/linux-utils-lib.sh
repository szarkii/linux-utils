function lib_printHelpOrVersionIfRequested {
    if [[ "$#" -eq 1 && ("$1" = "-h" || "$1" = "--help") ]]; then
        echo -e "$HELP"
        exit
    elif [[ "$1" = "-v" || "$1" = "--version" ]]; then
        version=$(dpkg -s shred-all | grep '^Version:' | sed -e 's/Version: //')
        echo "$version"
        exit
    fi
}

function lib_printHelpAndExit {
    if [[ ! -z "$1" ]]; then
        echo -e "$1"
        echo
    fi
    
    echo -e "$HELP"
    exit 1
}

lib_getFormattedTime() {
    date '+%Y-%m-%d %H:%M:%S_%N' | cut -c 1-23
}

lib_logInfo() {
    echo "[INFO] $(lib_getFormattedTime) $1"
}

lib_logWarn() {
    echo "[WARN] $(lib_getFormattedTime) $1"
}

lib_logSuccess() {
    echo "[SUCC] $(lib_getFormattedTime) $1"
}

lib_logError() {
    echo "[ERRO] $(lib_getFormattedTime) $1"
}

lib_logSeparator() {
    echo
}