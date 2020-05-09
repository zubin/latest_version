_latest_version() {
  COMPREPLY=()
  local word="${COMP_WORDS[COMP_CWORD]}"
  case "$COMP_CWORD" in
    1 )
      local words="$(latest_version --help |awk '/^  [a-z]/ {print $2}')"
      local completions="$(compgen -W "$words" -- "$word")"
      COMPREPLY=( $completions )
      ;;
    2 )
      case "${COMP_WORDS[1]}" in
        completion )
          local words="$(latest_version completions)"
          local completions="$(compgen -W "$words" -- "$word")"
          COMPREPLY=( $completions )
          ;;
      esac
      ;;
  esac
}

alias lv=latest_version
complete -F _latest_version latest_version lv
