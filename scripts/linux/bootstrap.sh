#!/usr/bin/env bash

linux_bootstrap() {
  local workspace="$1"

  log_title "Linux environment"
  log_info "Distribution: ${OS_NAME}"
  log_info "Distribution ID: ${OS_ID}"
  log_info "Version: ${OS_VERSION}"
  log_info "Architecture: ${ARCH}"
  log_info "User: ${CURRENT_USER}"
  log_info "Workspace: ${workspace}"

  case "${OS_ID}" in
    ubuntu|debian|linuxmint|fedora|rocky|arch)
      log_success "Supported Linux distribution detected."
      ;;
    *)
      log_warning "Linux distribution not yet validated: ${OS_ID}."
      ;;
  esac

  log_info "Sprint 1 runs in validation-only mode."
  log_info "No packages, files, users, services or system settings will be changed."
}
