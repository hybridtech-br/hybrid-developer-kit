#!/usr/bin/env bash
set -Eeuo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION_FILE="${ROOT_DIR}/VERSION"

# shellcheck source=scripts/shared/colors.sh
source "${ROOT_DIR}/scripts/shared/colors.sh"
# shellcheck source=scripts/shared/logging.sh
source "${ROOT_DIR}/scripts/shared/logging.sh"
# shellcheck source=scripts/shared/os.sh
source "${ROOT_DIR}/scripts/shared/os.sh"
# shellcheck source=scripts/shared/checks.sh
source "${ROOT_DIR}/scripts/shared/checks.sh"

HDK_VERSION="unknown"
[[ -f "${VERSION_FILE}" ]] && HDK_VERSION="$(tr -d '[:space:]' < "${VERSION_FILE}")"
WORKSPACE="${HYBRID_WORKSPACE:-${HOME}/workspace/hybrid}"

main() {
  print_banner "HYBRID Developer Kit" "Version ${HDK_VERSION}"

  detect_environment
  run_environment_checks "${WORKSPACE}"

  case "${OS_FAMILY}" in
    linux)
      # shellcheck source=scripts/linux/bootstrap.sh
      source "${ROOT_DIR}/scripts/linux/bootstrap.sh"
      linux_bootstrap "${WORKSPACE}"
      ;;
    macos)
      log_warning "O suporte ao macOS está planejado, mas ainda não foi implementado."
      ;;
    windows)
      log_warning "O suporte ao Windows está planejado, mas ainda não foi implementado."
      ;;
    *)
      log_error "Sistema operacional não suportado: ${OS_FAMILY}"
      return 1
      ;;
  esac

  print_environment_report "${WORKSPACE}"
  log_success "Validação do ambiente concluída. Nenhuma alteração foi feita no sistema."
}

main "$@"
