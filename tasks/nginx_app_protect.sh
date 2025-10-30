#!/bin/bash
set -e

# Puppet task for executing Ansible role: nginxinc_nginx_core
# This script runs the entire role via ansible-playbook

# Determine the ansible modules directory
if [ -n "$PT__installdir" ]; then
  ANSIBLE_DIR="$PT__installdir/lib/puppet_x/ansible_modules/nginxinc_nginx_core"
else
  # Fallback to /opt/puppetlabs/puppet/cache/lib/puppet_x/ansible_modules
  ANSIBLE_DIR="/opt/puppetlabs/puppet/cache/lib/puppet_x/ansible_modules/nginxinc_nginx_core"
fi

# Check if ansible-playbook is available
if ! command -v ansible-playbook &> /dev/null; then
  echo '{"_error": {"msg": "ansible-playbook command not found. Please install Ansible.", "kind": "puppet-ansible-converter/ansible-not-found"}}'
  exit 1
fi

# Check if the role directory exists
if [ ! -d "$ANSIBLE_DIR" ]; then
  echo "{\"_error\": {\"msg\": \"Ansible role directory not found: $ANSIBLE_DIR\", \"kind\": \"puppet-ansible-converter/role-not-found\"}}"
  exit 1
fi

# Detect playbook location (collection vs standalone)
# Collections: ansible_modules/collection_name/roles/role_name/playbook.yml
# Standalone: ansible_modules/role_name/playbook.yml
if [ -d "$ANSIBLE_DIR/roles" ] && [ -f "$ANSIBLE_DIR/roles/nginx_app_protect/playbook.yml" ]; then
  # Collection structure
  PLAYBOOK_PATH="$ANSIBLE_DIR/roles/nginx_app_protect/playbook.yml"
  PLAYBOOK_DIR="$ANSIBLE_DIR/roles/nginx_app_protect"
elif [ -f "$ANSIBLE_DIR/playbook.yml" ]; then
  # Standalone role structure
  PLAYBOOK_PATH="$ANSIBLE_DIR/playbook.yml"
  PLAYBOOK_DIR="$ANSIBLE_DIR"
else
  echo "{\"_error\": {\"msg\": \"playbook.yml not found in $ANSIBLE_DIR or $ANSIBLE_DIR/roles/nginx_app_protect\", \"kind\": \"puppet-ansible-converter/playbook-not-found\"}}"
  exit 1
fi

# Build extra-vars from PT_* environment variables (excluding par_* control params)
EXTRA_VARS="{"
FIRST=true
if [ -n "$PT_nginx_app_protect_timeoutstartsec" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_timeoutstartsec\": \"$PT_nginx_app_protect_timeoutstartsec\""
fi
if [ -n "$PT_nginx_app_protect_timeoutstopsec" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_timeoutstopsec\": \"$PT_nginx_app_protect_timeoutstopsec\""
fi
if [ -n "$PT_nginx_app_protect_waf_enable" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_waf_enable\": \"$PT_nginx_app_protect_waf_enable\""
fi
if [ -n "$PT_nginx_app_protect_dos_enable" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_dos_enable\": \"$PT_nginx_app_protect_dos_enable\""
fi
if [ -n "$PT_nginx_app_protect_waf_setup" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_waf_setup\": \"$PT_nginx_app_protect_waf_setup\""
fi
if [ -n "$PT_nginx_app_protect_dos_setup" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_dos_setup\": \"$PT_nginx_app_protect_dos_setup\""
fi
if [ -n "$PT_nginx_app_protect_use_rhel_subscription_repos" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_use_rhel_subscription_repos\": \"$PT_nginx_app_protect_use_rhel_subscription_repos\""
fi
if [ -n "$PT_nginx_app_protect_waf_install_signatures" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_waf_install_signatures\": \"$PT_nginx_app_protect_waf_install_signatures\""
fi
if [ -n "$PT_nginx_app_protect_waf_install_threat_campaigns" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_waf_install_threat_campaigns\": \"$PT_nginx_app_protect_waf_install_threat_campaigns\""
fi
if [ -n "$PT_nginx_app_protect_waf_manage_repo" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_waf_manage_repo\": \"$PT_nginx_app_protect_waf_manage_repo\""
fi
if [ -n "$PT_nginx_app_protect_dos_manage_repo" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_dos_manage_repo\": \"$PT_nginx_app_protect_dos_manage_repo\""
fi
if [ -n "$PT_nginx_app_protect_license" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_license\": \"$PT_nginx_app_protect_license\""
fi
if [ -n "$PT_nginx_app_protect_setup_license" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_setup_license\": \"$PT_nginx_app_protect_setup_license\""
fi
if [ -n "$PT_nginx_app_protect_remove_license" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_remove_license\": \"$PT_nginx_app_protect_remove_license\""
fi
if [ -n "$PT_nginx_app_protect_start" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_start\": \"$PT_nginx_app_protect_start\""
fi
if [ -n "$PT_nginx_app_protect_service_modify" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_service_modify\": \"$PT_nginx_app_protect_service_modify\""
fi
if [ -n "$PT_nginx_app_protect_timeoutstopcsec" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_timeoutstopcsec\": \"$PT_nginx_app_protect_timeoutstopcsec\""
fi
if [ -n "$PT_nginx_app_protect_security_policy_file_enable" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_security_policy_file_enable\": \"$PT_nginx_app_protect_security_policy_file_enable\""
fi
if [ -n "$PT_nginx_app_protect_security_policy_file" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_security_policy_file\": \"$PT_nginx_app_protect_security_policy_file\""
fi
if [ -n "$PT_nginx_app_protect_log_policy_file_enable" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_log_policy_file_enable\": \"$PT_nginx_app_protect_log_policy_file_enable\""
fi
if [ -n "$PT_nginx_app_protect_log_policy_file" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_log_policy_file\": \"$PT_nginx_app_protect_log_policy_file\""
fi
if [ -n "$PT_nginx_app_protect_selinux" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_selinux\": \"$PT_nginx_app_protect_selinux\""
fi
if [ -n "$PT_nginx_app_protect_selinux_enforcing" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_selinux_enforcing\": \"$PT_nginx_app_protect_selinux_enforcing\""
fi
if [ -n "$PT_nginx_app_protect_selinux_tempdir" ]; then
  if [ "$FIRST" = true ]; then
    FIRST=false
  else
    EXTRA_VARS="$EXTRA_VARS,"
  fi
  EXTRA_VARS="$EXTRA_VARS\"nginx_app_protect_selinux_tempdir\": \"$PT_nginx_app_protect_selinux_tempdir\""
fi
EXTRA_VARS="$EXTRA_VARS}"

# Build ansible-playbook command matching PAR provider exactly
# See: https://github.com/garrettrowell/puppet-par/blob/main/lib/puppet/provider/par/par.rb#L166
cd "$PLAYBOOK_DIR"

# Base command with inventory and connection (matching PAR)
ANSIBLE_CMD="ansible-playbook -i localhost, --connection=local"

# Add extra-vars (playbook variables)
ANSIBLE_CMD="$ANSIBLE_CMD -e \"$EXTRA_VARS\""

# Add tags if specified
if [ -n "$PT_par_tags" ]; then
  TAGS=$(echo "$PT_par_tags" | sed 's/\[//;s/\]//;s/"//g;s/,/,/g')
  ANSIBLE_CMD="$ANSIBLE_CMD --tags \"$TAGS\""
fi

# Add skip-tags if specified
if [ -n "$PT_par_skip_tags" ]; then
  SKIP_TAGS=$(echo "$PT_par_skip_tags" | sed 's/\[//;s/\]//;s/"//g;s/,/,/g')
  ANSIBLE_CMD="$ANSIBLE_CMD --skip-tags \"$SKIP_TAGS\""
fi

# Add start-at-task if specified
if [ -n "$PT_par_start_at_task" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --start-at-task \"$PT_par_start_at_task\""
fi

# Add limit if specified
if [ -n "$PT_par_limit" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --limit \"$PT_par_limit\""
fi

# Add verbose flag if specified
if [ "$PT_par_verbose" = "true" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD -v"
fi

# Add check mode flag if specified
if [ "$PT_par_check_mode" = "true" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --check"
fi

# Add user if specified
if [ -n "$PT_par_user" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --user \"$PT_par_user\""
fi

# Add timeout if specified
if [ -n "$PT_par_timeout" ]; then
  ANSIBLE_CMD="$ANSIBLE_CMD --timeout $PT_par_timeout"
fi

# Add playbook path as last argument (matching PAR)
ANSIBLE_CMD="$ANSIBLE_CMD playbook.yml"

# Set environment variables if specified (matching PAR env_vars handling)
if [ -n "$PT_par_env_vars" ]; then
  # Parse JSON hash and export variables
  eval $(echo "$PT_par_env_vars" | sed 's/[{}]//g;s/": "/=/g;s/","/;export /g;s/"//g' | sed 's/^/export /')
fi

# Set required Ansible environment (matching PAR)
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export ANSIBLE_STDOUT_CALLBACK=json

# Execute ansible-playbook
eval $ANSIBLE_CMD 2>&1

EXIT_CODE=$?

# Return JSON result
if [ $EXIT_CODE -eq 0 ]; then
  echo '{"status": "success", "role": "nginxinc_nginx_core"}'
else
  echo "{\"status\": \"failed\", \"role\": \"nginxinc_nginx_core\", \"exit_code\": $EXIT_CODE}"
fi

exit $EXIT_CODE
