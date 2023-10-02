fn () {
    local _version='0'
    emulate -LR zsh
    local flag_help flag_version
    local usage=(
        "Usage:"
        "  fn                          *TBD*"
        "Options:"
        "  -h --help                    print this message"
        "  --version                    print version"
    )
    zmodload zsh/zutil
    zparseopts -D -F -- {h,-help}=flag_help -version=flag_version \
        || return 1
    [[ -z "$flag_help" ]] || { print -l $usage && return }
    [[ -n "$flag_version" ]] && { print "${0} version ${_version}" && return }

    ## MAIN ##
    [[ -n $@ ]] && print -- "${@}" || \
        { [[ -p "/dev/stdin" ]] && print -- "$(cat)" || \
          print -- "$(pbpaste | col -b)" }
}
