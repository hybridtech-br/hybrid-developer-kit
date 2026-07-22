#!/usr/bin/env bash

log_info() {
  printf '%b[INFO]%b %s\n' "${HDK_COLOR_BLUE}" "${HDK_COLOR_RESET}" "$*"
}

log_success() {
  printf '%b[OK]%b %s\n' "${HDK_COLOR_GREEN}" "${HDK_COLOR_RESET}" "$*"
}

log_warning() {
  printf '%b[WARN]%b %s\n' "${HDK_COLOR_YELLOW}" "${HDK_COLOR_RESET}" "$*" >&2
}

log_error() {
  printf '%b[ERROR]%b %s\n' "${HDK_COLOR_RED}" "${HDK_COLOR_RESET}" "$*" >&2
}

print_banner() {
  local title="$1"
  local subtitle="${2:-}"
  printf '%b==================================================%b\n' "${HDK_COLOR_BOLD}" "${HDK_COLOR_RESET}"
  printf '%b%s%b\n' "${HDK_COLOR_BOLD}" "${title}" "${HDK_COLOR_RESET}"
  [[ -n "${subtitle}" ]] && printf '%s\n' "${subtitle}"
  printf '%b==================================================%b\n\n' "${HDK_COLOR_BOLD}" "${HDK_COLOR_RESET}"
}
