#!/usr/bin/env bash

CHECK_INTERNET="UNKNOWN"
CHECK_SUDO="UNKNOWN"
CHECK_DISK="UNKNOWN"
CHECK_WORKSPACE="UNKNOWN"

check_internet() {
  if command -v curl >/dev/null 2>&1 && curl -fsS --max-time 5 https://github.com >/dev/null 2>&1; then
    CHECK_INTERNET="OK"
  elif command -v wget >/dev/null 2>&1 && wget -q --timeout=5 --spider https://github.com >/dev/null 2>&1; then
    CHECK_INTERNET="OK"
  else
    CHECK_INTERNET="WARN"
  fi
}

check_sudo() {
  if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    CHECK_SUDO="ROOT"
  elif command -v sudo >/dev/null 2>&1; then
    CHECK_SUDO="OK"
  else
    CHECK_SUDO="WARN"
  fi
}

check_disk_space() {
  local available_kb
  available_kb="$(df -Pk "${HOME:-/}" 2>/dev/null | awk 'NR==2 {print $4}')"
  if [[ "${available_kb}" =~ ^[0-9]+$ ]] && (( available_kb >= 2097152 )); then
    CHECK_DISK="OK"
  else
    CHECK_DISK="WARN"
  fi
}

check_workspace() {
  local workspace="$1"
  local parent
  parent="$(dirname "${workspace}")"

  if [[ -d "${workspace}" && -w "${workspace}" ]]; then
    CHECK_WORKSPACE="OK"
  elif [[ -d "${parent}" && -w "${parent}" ]]; then
    CHECK_WORKSPACE="READY"
  else
    CHECK_WORKSPACE="WARN"
  fi
}

run_environment_checks() {
  local workspace="$1"
  check_internet
  check_sudo
  check_disk_space
  check_workspace "${workspace}"
}

print_environment_report() {
  local workspace="$1"

  printf '\n'
  printf '%-18s: %s\n' "Operating System" "${OS_FAMILY}"
  printf '%-18s: %s\n' "Distribution" "${OS_NAME}"
  printf '%-18s: %s\n' "Version" "${OS_VERSION}"
  printf '%-18s: %s\n' "Architecture" "${ARCH}"
  printf '%-18s: %s\n' "User" "${CURRENT_USER}"
  printf '%-18s: %s\n' "Home" "${USER_HOME}"
  printf '%-18s: %s\n' "Workspace" "${workspace}"
  printf '%-18s: %s\n' "Internet" "${CHECK_INTERNET}"
  printf '%-18s: %s\n' "Sudo" "${CHECK_SUDO}"
  printf '%-18s: %s\n' "Disk" "${CHECK_DISK}"
  printf '%-18s: %s\n' "Workspace status" "${CHECK_WORKSPACE}"
  printf '\n'
}
