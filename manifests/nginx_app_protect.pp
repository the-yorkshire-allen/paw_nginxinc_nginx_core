# paw_nginxinc_nginx_core::nginx_app_protect
# @summary Manage paw_nginxinc_nginx_core configuration
#
# @param nginx_app_protect_timeoutstartsec
# @param nginx_app_protect_timeoutstopsec
# @param nginx_app_protect_waf_enable Specify whether or not this role should install the NGINX App Protect WAF product.
# @param nginx_app_protect_dos_enable Specify whether or not this role should install the NGINX App Protect DoS product.
# @param nginx_app_protect_waf_setup Default is install.
# @param nginx_app_protect_dos_setup Default is install.
# @param nginx_app_protect_use_rhel_subscription_repos Default is false.
# @param nginx_app_protect_waf_install_signatures Default is true.
# @param nginx_app_protect_waf_install_threat_campaigns Default is true.
# @param nginx_app_protect_waf_manage_repo Default is true
# @param nginx_app_protect_dos_manage_repo Default is true
# @param nginx_app_protect_license Default is the files folder within the NGINX Ansible role.
# @param nginx_app_protect_setup_license Default is true.
# @param nginx_app_protect_remove_license Default is true.
# @param nginx_app_protect_start Default is true.
# @param nginx_app_protect_service_modify Default is commented out.
# @param nginx_app_protect_timeoutstopcsec
# @param nginx_app_protect_security_policy_file_enable Copy local NGINX App Protect security policy to host
# @param nginx_app_protect_security_policy_file
# @param nginx_app_protect_log_policy_file_enable Copy local NGINX App Protect log policy to host
# @param nginx_app_protect_log_policy_file
# @param nginx_app_protect_selinux Set SELinux enforcing for NGINX (CentOS/Red Hat only) - you may need to open ports on your own
# @param nginx_app_protect_selinux_enforcing Enable enforcing mode if true.  Permissive if false (audit only, no enforcing) globally (only works with nginx_selinux: true)
# @param nginx_app_protect_selinux_tempdir Temporary directory to hold selinux modules
# @param par_tags Array of tags to execute
# @param par_skip_tags Array of tags to skip
# @param par_start_at_task Task name to start execution from
# @param par_limit Limit execution to specific hosts pattern
# @param par_verbose Boolean to enable verbose output
# @param par_check_mode Boolean to run playbook in check mode
# @param par_timeout Maximum execution time in seconds
# @param par_user User to run ansible-playbook as
# @param par_env_vars Hash of environment variables
# @param par_logoutput Boolean to display full Ansible output
# @param par_exclusive Boolean to enable exclusive locking
class paw_nginxinc_nginx_core::nginx_app_protect (
  Integer $nginx_app_protect_timeoutstartsec = 180,
  Optional[String] $nginx_app_protect_timeoutstopsec = undef,
  Boolean $nginx_app_protect_waf_enable = true,
  Boolean $nginx_app_protect_dos_enable = false,
  String $nginx_app_protect_waf_setup = 'install',
  String $nginx_app_protect_dos_setup = 'install',
  Boolean $nginx_app_protect_use_rhel_subscription_repos = false,
  Boolean $nginx_app_protect_waf_install_signatures = true,
  Boolean $nginx_app_protect_waf_install_threat_campaigns = true,
  Boolean $nginx_app_protect_waf_manage_repo = true,
  Boolean $nginx_app_protect_dos_manage_repo = true,
  Hash $nginx_app_protect_license = { 'certificate' => 'license/nginx-repo.crt', 'key' => 'license/nginx-repo.key' },
  Boolean $nginx_app_protect_setup_license = true,
  Boolean $nginx_app_protect_remove_license = true,
  Boolean $nginx_app_protect_start = true,
  Boolean $nginx_app_protect_service_modify = true,
  Integer $nginx_app_protect_timeoutstopcsec = 180,
  Boolean $nginx_app_protect_security_policy_file_enable = false,
  Array $nginx_app_protect_security_policy_file = [{ 'src' => 'files/config/security-policy.json', 'dest' => '/etc/app_protect/conf/security-policy.json' }],
  Boolean $nginx_app_protect_log_policy_file_enable = false,
  Array $nginx_app_protect_log_policy_file = [{ 'src' => 'files/config/log-policy.json', 'dest' => '/etc/app_protect/conf/log-policy.json' }],
  Boolean $nginx_app_protect_selinux = false,
  Boolean $nginx_app_protect_selinux_enforcing = true,
  String $nginx_app_protect_selinux_tempdir = '/tmp',
  Optional[Array[String]] $par_tags = undef,
  Optional[Array[String]] $par_skip_tags = undef,
  Optional[String] $par_start_at_task = undef,
  Optional[String] $par_limit = undef,
  Optional[Boolean] $par_verbose = undef,
  Optional[Boolean] $par_check_mode = undef,
  Optional[Integer] $par_timeout = undef,
  Optional[String] $par_user = undef,
  Optional[Hash] $par_env_vars = undef,
  Optional[Boolean] $par_logoutput = undef,
  Optional[Boolean] $par_exclusive = undef
) {
  # Execute the Ansible role using PAR (Puppet Ansible Runner)
  $vardir = pick($facts['puppet_vardir'], $settings::vardir, '/opt/puppetlabs/puppet/cache')
  $playbook_path = "${vardir}/lib/puppet_x/ansible_modules/nginxinc_nginx_core/roles/nginx_app_protect/playbook.yml"

  par { 'paw_nginxinc_nginx_core_nginx_app_protect-main':
    ensure        => present,
    playbook      => $playbook_path,
    playbook_vars => {
      'nginx_app_protect_timeoutstartsec'              => $nginx_app_protect_timeoutstartsec,
      'nginx_app_protect_timeoutstopsec'               => $nginx_app_protect_timeoutstopsec,
      'nginx_app_protect_waf_enable'                   => $nginx_app_protect_waf_enable,
      'nginx_app_protect_dos_enable'                   => $nginx_app_protect_dos_enable,
      'nginx_app_protect_waf_setup'                    => $nginx_app_protect_waf_setup,
      'nginx_app_protect_dos_setup'                    => $nginx_app_protect_dos_setup,
      'nginx_app_protect_use_rhel_subscription_repos'  => $nginx_app_protect_use_rhel_subscription_repos,
      'nginx_app_protect_waf_install_signatures'       => $nginx_app_protect_waf_install_signatures,
      'nginx_app_protect_waf_install_threat_campaigns' => $nginx_app_protect_waf_install_threat_campaigns,
      'nginx_app_protect_waf_manage_repo'              => $nginx_app_protect_waf_manage_repo,
      'nginx_app_protect_dos_manage_repo'              => $nginx_app_protect_dos_manage_repo,
      'nginx_app_protect_license'                      => $nginx_app_protect_license,
      'nginx_app_protect_setup_license'                => $nginx_app_protect_setup_license,
      'nginx_app_protect_remove_license'               => $nginx_app_protect_remove_license,
      'nginx_app_protect_start'                        => $nginx_app_protect_start,
      'nginx_app_protect_service_modify'               => $nginx_app_protect_service_modify,
      'nginx_app_protect_timeoutstopcsec'              => $nginx_app_protect_timeoutstopcsec,
      'nginx_app_protect_security_policy_file_enable'  => $nginx_app_protect_security_policy_file_enable,
      'nginx_app_protect_security_policy_file'         => $nginx_app_protect_security_policy_file,
      'nginx_app_protect_log_policy_file_enable'       => $nginx_app_protect_log_policy_file_enable,
      'nginx_app_protect_log_policy_file'              => $nginx_app_protect_log_policy_file,
      'nginx_app_protect_selinux'                      => $nginx_app_protect_selinux,
      'nginx_app_protect_selinux_enforcing'            => $nginx_app_protect_selinux_enforcing,
      'nginx_app_protect_selinux_tempdir'              => $nginx_app_protect_selinux_tempdir,
    },
    tags          => $par_tags,
    skip_tags     => $par_skip_tags,
    start_at_task => $par_start_at_task,
    limit         => $par_limit,
    verbose       => $par_verbose,
    check_mode    => $par_check_mode,
    timeout       => $par_timeout,
    user          => $par_user,
    env_vars      => $par_env_vars,
    logoutput     => $par_logoutput,
    exclusive     => $par_exclusive,
  }
}
