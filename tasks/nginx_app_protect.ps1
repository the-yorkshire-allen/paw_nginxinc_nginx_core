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
$CollectionPlaybook = Join-Path $AnsibleDir "roles\nginx_app_protect\playbook.yml"
$StandalonePlaybook = Join-Path $AnsibleDir "playbook.yml"

if ((Test-Path (Join-Path $AnsibleDir "roles")) -and (Test-Path $CollectionPlaybook)) {
  # Collection structure
  $PlaybookPath = $CollectionPlaybook
  $PlaybookDir = Join-Path $AnsibleDir "roles\nginx_app_protect"
} elseif (Test-Path $StandalonePlaybook) {
  # Standalone role structure
  $PlaybookPath = $StandalonePlaybook
  $PlaybookDir = $AnsibleDir
} else {
  $result = @{
    _error = @{
      msg = "playbook.yml not found in $AnsibleDir or $AnsibleDir\roles\nginx_app_protect"
      kind = "puppet-ansible-converter/playbook-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Build extra-vars from PT_* environment variables
$ExtraVars = @{}
if ($env:PT_nginx_app_protect_timeoutstartsec) {
  $ExtraVars['nginx_app_protect_timeoutstartsec'] = $env:PT_nginx_app_protect_timeoutstartsec
}
if ($env:PT_nginx_app_protect_timeoutstopsec) {
  $ExtraVars['nginx_app_protect_timeoutstopsec'] = $env:PT_nginx_app_protect_timeoutstopsec
}
if ($env:PT_nginx_app_protect_waf_enable) {
  $ExtraVars['nginx_app_protect_waf_enable'] = $env:PT_nginx_app_protect_waf_enable
}
if ($env:PT_nginx_app_protect_dos_enable) {
  $ExtraVars['nginx_app_protect_dos_enable'] = $env:PT_nginx_app_protect_dos_enable
}
if ($env:PT_nginx_app_protect_waf_setup) {
  $ExtraVars['nginx_app_protect_waf_setup'] = $env:PT_nginx_app_protect_waf_setup
}
if ($env:PT_nginx_app_protect_dos_setup) {
  $ExtraVars['nginx_app_protect_dos_setup'] = $env:PT_nginx_app_protect_dos_setup
}
if ($env:PT_nginx_app_protect_use_rhel_subscription_repos) {
  $ExtraVars['nginx_app_protect_use_rhel_subscription_repos'] = $env:PT_nginx_app_protect_use_rhel_subscription_repos
}
if ($env:PT_nginx_app_protect_waf_install_signatures) {
  $ExtraVars['nginx_app_protect_waf_install_signatures'] = $env:PT_nginx_app_protect_waf_install_signatures
}
if ($env:PT_nginx_app_protect_waf_install_threat_campaigns) {
  $ExtraVars['nginx_app_protect_waf_install_threat_campaigns'] = $env:PT_nginx_app_protect_waf_install_threat_campaigns
}
if ($env:PT_nginx_app_protect_waf_manage_repo) {
  $ExtraVars['nginx_app_protect_waf_manage_repo'] = $env:PT_nginx_app_protect_waf_manage_repo
}
if ($env:PT_nginx_app_protect_dos_manage_repo) {
  $ExtraVars['nginx_app_protect_dos_manage_repo'] = $env:PT_nginx_app_protect_dos_manage_repo
}
if ($env:PT_nginx_app_protect_license) {
  $ExtraVars['nginx_app_protect_license'] = $env:PT_nginx_app_protect_license
}
if ($env:PT_nginx_app_protect_setup_license) {
  $ExtraVars['nginx_app_protect_setup_license'] = $env:PT_nginx_app_protect_setup_license
}
if ($env:PT_nginx_app_protect_remove_license) {
  $ExtraVars['nginx_app_protect_remove_license'] = $env:PT_nginx_app_protect_remove_license
}
if ($env:PT_nginx_app_protect_start) {
  $ExtraVars['nginx_app_protect_start'] = $env:PT_nginx_app_protect_start
}
if ($env:PT_nginx_app_protect_service_modify) {
  $ExtraVars['nginx_app_protect_service_modify'] = $env:PT_nginx_app_protect_service_modify
}
if ($env:PT_nginx_app_protect_timeoutstopcsec) {
  $ExtraVars['nginx_app_protect_timeoutstopcsec'] = $env:PT_nginx_app_protect_timeoutstopcsec
}
if ($env:PT_nginx_app_protect_security_policy_file_enable) {
  $ExtraVars['nginx_app_protect_security_policy_file_enable'] = $env:PT_nginx_app_protect_security_policy_file_enable
}
if ($env:PT_nginx_app_protect_security_policy_file) {
  $ExtraVars['nginx_app_protect_security_policy_file'] = $env:PT_nginx_app_protect_security_policy_file
}
if ($env:PT_nginx_app_protect_log_policy_file_enable) {
  $ExtraVars['nginx_app_protect_log_policy_file_enable'] = $env:PT_nginx_app_protect_log_policy_file_enable
}
if ($env:PT_nginx_app_protect_log_policy_file) {
  $ExtraVars['nginx_app_protect_log_policy_file'] = $env:PT_nginx_app_protect_log_policy_file
}
if ($env:PT_nginx_app_protect_selinux) {
  $ExtraVars['nginx_app_protect_selinux'] = $env:PT_nginx_app_protect_selinux
}
if ($env:PT_nginx_app_protect_selinux_enforcing) {
  $ExtraVars['nginx_app_protect_selinux_enforcing'] = $env:PT_nginx_app_protect_selinux_enforcing
}
if ($env:PT_nginx_app_protect_selinux_tempdir) {
  $ExtraVars['nginx_app_protect_selinux_tempdir'] = $env:PT_nginx_app_protect_selinux_tempdir
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
