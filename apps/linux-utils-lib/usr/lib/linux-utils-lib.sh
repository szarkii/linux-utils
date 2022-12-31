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