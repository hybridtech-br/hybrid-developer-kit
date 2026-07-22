#!/usr/bin/env bash

OS_FAMILY="unknown"
OS_NAME="unknown"
OS_ID="unknown"
OS_VERSION="unknown"
ARCH="unknown"
CURRENT_USER="unknown"
USER_HOME="${HOME:-unknown}"

normalize_architecture() {
  local raw_arch
  raw_arch="$(uname -m 2>/dev/null || printf 'unknown')"
  case "${raw_arch}" in
    x86_64|amd64) ARCH="x86_64" ;;
    arm64|aarch64) ARCH="arm64" ;;
    armv7l) ARCH="armv7" ;;
    *) ARCH="${raw_arch}" ;;
  esac
}

detect_linux_distribution() {
  if [[ -r /etc/os-release ]]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    OS_ID="${ID:-linux}"
    OS_NAME="${PRETTY_NAME:-${NAME:-Linux}}"
    OS_VERSION="${VERSION_ID:-unknown}"
  else
    OS_ID="linux"
    OS_NAME="Linux"
    OS_VERSION="unknown"
  fi
}

detect_environment() {
  local kernel
  kernel="$(uname -s 2>/dev/null || printf 'unknown')"

  case "${kernel}" in
    Linux)
      OS_FAMILY="linux"
      detect_linux_distribution
      ;;
    Darwin)
      OS_FAMILY="macos"
      OS_ID="macos"
      OS_NAME="macOS"
      OS_VERSION="$(sw_vers -productVersion 2>/dev/null || printf 'unknown')"
      ;;
    MINGW*|MSYS*|CYGWIN*)
      OS_FAMILY="windows"
      OS_ID="windows"
      OS_NAME="Windows"
      OS_VERSION="unknown"
      ;;
    *)
      OS_FAMILY="unknown"
      OS_ID="unknown"
      OS_NAME="${kernel}"
      OS_VERSION="unknown"
      ;;
  esac

  normalize_architecture
  CURRENT_USER="$(id -un 2>/dev/null || whoami 2>/dev/null || printf 'unknown')"
  USER_HOME="${HOME:-unknown}"
}
