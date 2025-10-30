# Puppet task for executing Ansible role: nginxinc_nginx_core
# This script runs the entire role via ansible-playbook

$ErrorActionPreference = 'Stop'

# Determine the ansible modules directory
if ($env:PT__installdir) {
  $AnsibleDir = Join-Path $env:PT__installdir "lib\puppet_x\ansible_modules\nginxinc_nginx_core"
} else {
  # Fallback to Puppet cache directory
  $AnsibleDir = "C:\ProgramData\PuppetLabs\puppet\cache\lib\puppet_x\ansible_modules\nginxinc_nginx_core"
}

# Check if ansible-playbook is available
$AnsiblePlaybook = Get-Command ansible-playbook -ErrorAction SilentlyContinue
if (-not $AnsiblePlaybook) {
  $result = @{
    _error = @{
      msg = "ansible-playbook command not found. Please install Ansible."
      kind = "puppet-ansible-converter/ansible-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Check if the role directory exists
if (-not (Test-Path $AnsibleDir)) {
  $result = @{
    _error = @{
      msg = "Ansible role directory not found: $AnsibleDir"
      kind = "puppet-ansible-converter/role-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Detect playbook location (collection vs standalone)
# Collections: ansible_modules/collection_name/roles/role_name/playbook.yml
# Standalone: ansible_modules/role_name/playbook.yml
$CollectionPlaybook = Join-Path $AnsibleDir "roles\nginx\playbook.yml"
$StandalonePlaybook = Join-Path $AnsibleDir "playbook.yml"

if ((Test-Path (Join-Path $AnsibleDir "roles")) -and (Test-Path $CollectionPlaybook)) {
  # Collection structure
  $PlaybookPath = $CollectionPlaybook
  $PlaybookDir = Join-Path $AnsibleDir "roles\nginx"
} elseif (Test-Path $StandalonePlaybook) {
  # Standalone role structure
  $PlaybookPath = $StandalonePlaybook
  $PlaybookDir = $AnsibleDir
} else {
  $result = @{
    _error = @{
      msg = "playbook.yml not found in $AnsibleDir or $AnsibleDir\roles\nginx"
      kind = "puppet-ansible-converter/playbook-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Build extra-vars from PT_* environment variables
$ExtraVars = @{}
if ($env:PT_path) {
  $ExtraVars['path'] = $env:PT_path
}
if ($env:PT_option) {
  $ExtraVars['option'] = $env:PT_option
}
if ($env:PT_nginx_service_timeoutstartsec) {
  $ExtraVars['nginx_service_timeoutstartsec'] = $env:PT_nginx_service_timeoutstartsec
}
if ($env:PT_nginx_service_timeoutstopsec) {
  $ExtraVars['nginx_service_timeoutstopsec'] = $env:PT_nginx_service_timeoutstopsec
}
if ($env:PT_nginx_service_restart) {
  $ExtraVars['nginx_service_restart'] = $env:PT_nginx_service_restart
}
if ($env:PT_nginx_service_restartsec) {
  $ExtraVars['nginx_service_restartsec'] = $env:PT_nginx_service_restartsec
}
if ($env:PT_nginx_amplify_enable) {
  $ExtraVars['nginx_amplify_enable'] = $env:PT_nginx_amplify_enable
}
if ($env:PT_nginx_amplify_api_key) {
  $ExtraVars['nginx_amplify_api_key'] = $env:PT_nginx_amplify_api_key
}
if ($env:PT_nginx_bsd_install_packages) {
  $ExtraVars['nginx_bsd_install_packages'] = $env:PT_nginx_bsd_install_packages
}
if ($env:PT_nginx_bsd_update_ports) {
  $ExtraVars['nginx_bsd_update_ports'] = $env:PT_nginx_bsd_update_ports
}
if ($env:PT_nginx_bsd_portinstall_use_packages) {
  $ExtraVars['nginx_bsd_portinstall_use_packages'] = $env:PT_nginx_bsd_portinstall_use_packages
}
if ($env:PT_nginx_logrotate_conf_enable) {
  $ExtraVars['nginx_logrotate_conf_enable'] = $env:PT_nginx_logrotate_conf_enable
}
if ($env:PT_nginx_logrotate_conf) {
  $ExtraVars['nginx_logrotate_conf'] = $env:PT_nginx_logrotate_conf
}
if ($env:PT_nginx_enable) {
  $ExtraVars['nginx_enable'] = $env:PT_nginx_enable
}
if ($env:PT_nginx_debug_output) {
  $ExtraVars['nginx_debug_output'] = $env:PT_nginx_debug_output
}
if ($env:PT_nginx_type) {
  $ExtraVars['nginx_type'] = $env:PT_nginx_type
}
if ($env:PT_nginx_start) {
  $ExtraVars['nginx_start'] = $env:PT_nginx_start
}
if ($env:PT_nginx_setup) {
  $ExtraVars['nginx_setup'] = $env:PT_nginx_setup
}
if ($env:PT_nginx_manage_repo) {
  $ExtraVars['nginx_manage_repo'] = $env:PT_nginx_manage_repo
}
if ($env:PT_nginx_install_from) {
  $ExtraVars['nginx_install_from'] = $env:PT_nginx_install_from
}
if ($env:PT_nginx_install_source_build_tools) {
  $ExtraVars['nginx_install_source_build_tools'] = $env:PT_nginx_install_source_build_tools
}
if ($env:PT_nginx_install_source_pcre) {
  $ExtraVars['nginx_install_source_pcre'] = $env:PT_nginx_install_source_pcre
}
if ($env:PT_nginx_install_source_openssl) {
  $ExtraVars['nginx_install_source_openssl'] = $env:PT_nginx_install_source_openssl
}
if ($env:PT_nginx_install_source_zlib) {
  $ExtraVars['nginx_install_source_zlib'] = $env:PT_nginx_install_source_zlib
}
if ($env:PT_nginx_static_modules) {
  $ExtraVars['nginx_static_modules'] = $env:PT_nginx_static_modules
}
if ($env:PT_nginx_branch) {
  $ExtraVars['nginx_branch'] = $env:PT_nginx_branch
}
if ($env:PT_nginx_license) {
  $ExtraVars['nginx_license'] = $env:PT_nginx_license
}
if ($env:PT_nginx_setup_license) {
  $ExtraVars['nginx_setup_license'] = $env:PT_nginx_setup_license
}
if ($env:PT_nginx_remove_license) {
  $ExtraVars['nginx_remove_license'] = $env:PT_nginx_remove_license
}
if ($env:PT_nginx_install_epel_release) {
  $ExtraVars['nginx_install_epel_release'] = $env:PT_nginx_install_epel_release
}
if ($env:PT_nginx_modules) {
  $ExtraVars['nginx_modules'] = $env:PT_nginx_modules
}
if ($env:PT_nginx_selinux) {
  $ExtraVars['nginx_selinux'] = $env:PT_nginx_selinux
}
if ($env:PT_nginx_selinux_enforcing) {
  $ExtraVars['nginx_selinux_enforcing'] = $env:PT_nginx_selinux_enforcing
}
if ($env:PT_nginx_selinux_tempdir) {
  $ExtraVars['nginx_selinux_tempdir'] = $env:PT_nginx_selinux_tempdir
}
if ($env:PT_nginx_service_modify) {
  $ExtraVars['nginx_service_modify'] = $env:PT_nginx_service_modify
}
if ($env:PT_nginx_service_clean) {
  $ExtraVars['nginx_service_clean'] = $env:PT_nginx_service_clean
}
if ($env:PT_nginx_service_overridepath) {
  $ExtraVars['nginx_service_overridepath'] = $env:PT_nginx_service_overridepath
}
if ($env:PT_nginx_service_overridefilename) {
  $ExtraVars['nginx_service_overridefilename'] = $env:PT_nginx_service_overridefilename
}
if ($env:PT_nginx_service_custom) {
  $ExtraVars['nginx_service_custom'] = $env:PT_nginx_service_custom
}
if ($env:PT_nginx_service_custom_file) {
  $ExtraVars['nginx_service_custom_file'] = $env:PT_nginx_service_custom_file
}

$ExtraVarsJson = $ExtraVars | ConvertTo-Json -Compress

# Execute ansible-playbook with the role
Push-Location $PlaybookDir
try {
  ansible-playbook playbook.yml `
    --extra-vars $ExtraVarsJson `
    --connection=local `
    --inventory=localhost, `
    2>&1 | Write-Output
  
  $ExitCode = $LASTEXITCODE
  
  if ($ExitCode -eq 0) {
    $result = @{
      status = "success"
      role = "nginxinc_nginx_core"
    }
  } else {
    $result = @{
      status = "failed"
      role = "nginxinc_nginx_core"
      exit_code = $ExitCode
    }
  }
  
  Write-Output ($result | ConvertTo-Json)
  exit $ExitCode
}
finally {
  Pop-Location
}
