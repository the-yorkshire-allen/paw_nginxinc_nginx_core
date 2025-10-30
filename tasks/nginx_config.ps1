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
$CollectionPlaybook = Join-Path $AnsibleDir "roles\nginx_config\playbook.yml"
$StandalonePlaybook = Join-Path $AnsibleDir "playbook.yml"

if ((Test-Path (Join-Path $AnsibleDir "roles")) -and (Test-Path $CollectionPlaybook)) {
  # Collection structure
  $PlaybookPath = $CollectionPlaybook
  $PlaybookDir = Join-Path $AnsibleDir "roles\nginx_config"
} elseif (Test-Path $StandalonePlaybook) {
  # Standalone role structure
  $PlaybookPath = $StandalonePlaybook
  $PlaybookDir = $AnsibleDir
} else {
  $result = @{
    _error = @{
      msg = "playbook.yml not found in $AnsibleDir or $AnsibleDir\roles\nginx_config"
      kind = "puppet-ansible-converter/playbook-not-found"
    }
  }
  Write-Output ($result | ConvertTo-Json)
  exit 1
}

# Build extra-vars from PT_* environment variables
$ExtraVars = @{}
if ($env:PT_module) {
  $ExtraVars['module'] = $env:PT_module
}
if ($env:PT_connection) {
  $ExtraVars['connection'] = $env:PT_connection
}
if ($env:PT_address) {
  $ExtraVars['address'] = $env:PT_address
}
if ($env:PT_signature) {
  $ExtraVars['signature'] = $env:PT_signature
}
if ($env:PT_allow) {
  $ExtraVars['allow'] = $env:PT_allow
}
if ($env:PT_deny) {
  $ExtraVars['deny'] = $env:PT_deny
}
if ($env:PT_file) {
  $ExtraVars['file'] = $env:PT_file
}
if ($env:PT_directive) {
  $ExtraVars['directive'] = $env:PT_directive
}
if ($env:PT_header) {
  $ExtraVars['header'] = $env:PT_header
}
if ($env:PT_command) {
  $ExtraVars['command'] = $env:PT_command
}
if ($env:PT_condition) {
  $ExtraVars['condition'] = $env:PT_condition
}
if ($env:PT_certificate) {
  $ExtraVars['certificate'] = $env:PT_certificate
}
if ($env:PT_key) {
  $ExtraVars['key'] = $env:PT_key
}
if ($env:PT_ansible_managed) {
  $ExtraVars['ansible_managed'] = $env:PT_ansible_managed
}
if ($env:PT_nginx_config_start) {
  $ExtraVars['nginx_config_start'] = $env:PT_nginx_config_start
}
if ($env:PT_nginx_config_debug_output) {
  $ExtraVars['nginx_config_debug_output'] = $env:PT_nginx_config_debug_output
}
if ($env:PT_nginx_config_cleanup) {
  $ExtraVars['nginx_config_cleanup'] = $env:PT_nginx_config_cleanup
}
if ($env:PT_nginx_config_selinux) {
  $ExtraVars['nginx_config_selinux'] = $env:PT_nginx_config_selinux
}
if ($env:PT_nginx_config_selinux_enforcing) {
  $ExtraVars['nginx_config_selinux_enforcing'] = $env:PT_nginx_config_selinux_enforcing
}
if ($env:PT_nginx_config_html_demo_template_enable) {
  $ExtraVars['nginx_config_html_demo_template_enable'] = $env:PT_nginx_config_html_demo_template_enable
}
if ($env:PT_nginx_config_html_demo_template) {
  $ExtraVars['nginx_config_html_demo_template'] = $env:PT_nginx_config_html_demo_template
}
if ($env:PT_nginx_config_main_template_enable) {
  $ExtraVars['nginx_config_main_template_enable'] = $env:PT_nginx_config_main_template_enable
}
if ($env:PT_nginx_config_main_template) {
  $ExtraVars['nginx_config_main_template'] = $env:PT_nginx_config_main_template
}
if ($env:PT_nginx_config_http_template_enable) {
  $ExtraVars['nginx_config_http_template_enable'] = $env:PT_nginx_config_http_template_enable
}
if ($env:PT_nginx_config_http_template) {
  $ExtraVars['nginx_config_http_template'] = $env:PT_nginx_config_http_template
}
if ($env:PT_nginx_config_status_enable) {
  $ExtraVars['nginx_config_status_enable'] = $env:PT_nginx_config_status_enable
}
if ($env:PT_nginx_config_status_template_file) {
  $ExtraVars['nginx_config_status_template_file'] = $env:PT_nginx_config_status_template_file
}
if ($env:PT_nginx_config_status_file_location) {
  $ExtraVars['nginx_config_status_file_location'] = $env:PT_nginx_config_status_file_location
}
if ($env:PT_nginx_config_status_backup) {
  $ExtraVars['nginx_config_status_backup'] = $env:PT_nginx_config_status_backup
}
if ($env:PT_nginx_config_status_port) {
  $ExtraVars['nginx_config_status_port'] = $env:PT_nginx_config_status_port
}
if ($env:PT_nginx_config_status_access_log) {
  $ExtraVars['nginx_config_status_access_log'] = $env:PT_nginx_config_status_access_log
}
if ($env:PT_nginx_config_status_allow) {
  $ExtraVars['nginx_config_status_allow'] = $env:PT_nginx_config_status_allow
}
if ($env:PT_nginx_config_status_deny) {
  $ExtraVars['nginx_config_status_deny'] = $env:PT_nginx_config_status_deny
}
if ($env:PT_nginx_config_rest_api_enable) {
  $ExtraVars['nginx_config_rest_api_enable'] = $env:PT_nginx_config_rest_api_enable
}
if ($env:PT_nginx_config_rest_api_template_file) {
  $ExtraVars['nginx_config_rest_api_template_file'] = $env:PT_nginx_config_rest_api_template_file
}
if ($env:PT_nginx_config_rest_api_file_location) {
  $ExtraVars['nginx_config_rest_api_file_location'] = $env:PT_nginx_config_rest_api_file_location
}
if ($env:PT_nginx_config_rest_api_backup) {
  $ExtraVars['nginx_config_rest_api_backup'] = $env:PT_nginx_config_rest_api_backup
}
if ($env:PT_nginx_config_rest_api_port) {
  $ExtraVars['nginx_config_rest_api_port'] = $env:PT_nginx_config_rest_api_port
}
if ($env:PT_nginx_config_rest_api_write) {
  $ExtraVars['nginx_config_rest_api_write'] = $env:PT_nginx_config_rest_api_write
}
if ($env:PT_nginx_config_rest_api_access_log) {
  $ExtraVars['nginx_config_rest_api_access_log'] = $env:PT_nginx_config_rest_api_access_log
}
if ($env:PT_nginx_config_rest_api_allow) {
  $ExtraVars['nginx_config_rest_api_allow'] = $env:PT_nginx_config_rest_api_allow
}
if ($env:PT_nginx_config_rest_api_deny) {
  $ExtraVars['nginx_config_rest_api_deny'] = $env:PT_nginx_config_rest_api_deny
}
if ($env:PT_nginx_config_rest_api_dashboard) {
  $ExtraVars['nginx_config_rest_api_dashboard'] = $env:PT_nginx_config_rest_api_dashboard
}
if ($env:PT_nginx_config_rest_api_dashboard_allow) {
  $ExtraVars['nginx_config_rest_api_dashboard_allow'] = $env:PT_nginx_config_rest_api_dashboard_allow
}
if ($env:PT_nginx_config_rest_api_dashboard_deny) {
  $ExtraVars['nginx_config_rest_api_dashboard_deny'] = $env:PT_nginx_config_rest_api_dashboard_deny
}
if ($env:PT_nginx_config_stream_template_enable) {
  $ExtraVars['nginx_config_stream_template_enable'] = $env:PT_nginx_config_stream_template_enable
}
if ($env:PT_nginx_config_stream_template) {
  $ExtraVars['nginx_config_stream_template'] = $env:PT_nginx_config_stream_template
}
if ($env:PT_nginx_config_upload_enable) {
  $ExtraVars['nginx_config_upload_enable'] = $env:PT_nginx_config_upload_enable
}
if ($env:PT_nginx_config_upload) {
  $ExtraVars['nginx_config_upload'] = $env:PT_nginx_config_upload
}
if ($env:PT_nginx_config_upload_html_enable) {
  $ExtraVars['nginx_config_upload_html_enable'] = $env:PT_nginx_config_upload_html_enable
}
if ($env:PT_nginx_config_upload_html) {
  $ExtraVars['nginx_config_upload_html'] = $env:PT_nginx_config_upload_html
}
if ($env:PT_nginx_config_upload_ssl_enable) {
  $ExtraVars['nginx_config_upload_ssl_enable'] = $env:PT_nginx_config_upload_ssl_enable
}
if ($env:PT_nginx_config_upload_ssl_crt) {
  $ExtraVars['nginx_config_upload_ssl_crt'] = $env:PT_nginx_config_upload_ssl_crt
}
if ($env:PT_nginx_config_upload_ssl_key) {
  $ExtraVars['nginx_config_upload_ssl_key'] = $env:PT_nginx_config_upload_ssl_key
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
