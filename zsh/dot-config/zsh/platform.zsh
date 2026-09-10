nikero_open() {
  case "$(uname -s)" in
    Darwin) open "$@" ;;
    Linux) xdg-open "$@" ;;
    *) printf 'Unsupported operating system: %s\n' "$(uname -s)" >&2; return 1 ;;
  esac
}

nikero_copy() {
  case "$(uname -s)" in
    Darwin) pbcopy ;;
    Linux) wl-copy ;;
    *) printf 'Unsupported operating system: %s\n' "$(uname -s)" >&2; return 1 ;;
  esac
}

nikero_paste() {
  case "$(uname -s)" in
    Darwin) pbpaste ;;
    Linux) wl-paste ;;
    *) printf 'Unsupported operating system: %s\n' "$(uname -s)" >&2; return 1 ;;
  esac
}
