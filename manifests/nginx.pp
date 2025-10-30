# paw_nginxinc_nginx_core::nginx
# @summary Manage paw_nginxinc_nginx_core configuration
#
# @param path
# @param option
# @param nginx_service_timeoutstartsec
# @param nginx_service_timeoutstopsec
# @param nginx_service_restart
# @param nginx_service_restartsec
# @param nginx_amplify_enable
# @param nginx_amplify_api_key
# @param nginx_bsd_install_packages
# @param nginx_bsd_update_ports
# @param nginx_bsd_portinstall_use_packages
# @param nginx_logrotate_conf_enable
# @param nginx_logrotate_conf
# @param nginx_enable
# @param nginx_debug_output
# @param nginx_type
# @param nginx_start
# @param nginx_setup
# @param nginx_manage_repo
# @param nginx_install_from
# @param nginx_install_source_build_tools
# @param nginx_install_source_pcre
# @param nginx_install_source_openssl
# @param nginx_install_source_zlib
# @param nginx_static_modules
# @param nginx_branch
# @param nginx_license
# @param nginx_setup_license
# @param nginx_remove_license
# @param nginx_install_epel_release
# @param nginx_modules
# @param nginx_selinux
# @param nginx_selinux_enforcing
# @param nginx_selinux_tempdir
# @param nginx_service_modify
# @param nginx_service_clean
# @param nginx_service_overridepath
# @param nginx_service_overridefilename
# @param nginx_service_custom
# @param nginx_service_custom_file
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
class paw_nginxinc_nginx_core::nginx (
  Optional[String] $path = undef,
  Optional[String] $option = undef,
  Optional[String] $nginx_service_timeoutstartsec = undef,
  Optional[String] $nginx_service_timeoutstopsec = undef,
  Optional[String] $nginx_service_restart = undef,
  Optional[String] $nginx_service_restartsec = undef,
  Boolean $nginx_amplify_enable = false,
  Optional[String] $nginx_amplify_api_key = undef,
  Boolean $nginx_bsd_install_packages = true,
  Boolean $nginx_bsd_update_ports = true,
  Boolean $nginx_bsd_portinstall_use_packages = true,
  Boolean $nginx_logrotate_conf_enable = false,
  Hash $nginx_logrotate_conf = { 'paths' => ['/var/log/nginx/*.log'], 'options' => ['daily', 'missingok', 'rotate 14', 'compress', 'delaycompress', 'notifempty', 'create 0644 www-data adm', 'sharedscripts'] },
  Boolean $nginx_enable = true,
  Boolean $nginx_debug_output = false,
  String $nginx_type = 'opensource',
  Boolean $nginx_start = true,
  String $nginx_setup = 'install',
  Boolean $nginx_manage_repo = true,
  String $nginx_install_from = 'nginx_repository',
  Boolean $nginx_install_source_build_tools = true,
  Boolean $nginx_install_source_pcre = false,
  Boolean $nginx_install_source_openssl = true,
  Boolean $nginx_install_source_zlib = false,
  Array $nginx_static_modules = ['http_ssl_module'],
  String $nginx_branch = 'mainline',
  Hash $nginx_license = { 'certificate' => 'license/nginx-repo.crt', 'key' => 'license/nginx-repo.key' },
  Boolean $nginx_setup_license = true,
  Boolean $nginx_remove_license = true,
  Boolean $nginx_install_epel_release = true,
  Array $nginx_modules = [],
  Boolean $nginx_selinux = false,
  Boolean $nginx_selinux_enforcing = true,
  String $nginx_selinux_tempdir = '/tmp',
  Boolean $nginx_service_modify = false,
  Boolean $nginx_service_clean = false,
  String $nginx_service_overridepath = '/etc/systemd/system/nginx.service.d',
  String $nginx_service_overridefilename = 'override.conf',
  Boolean $nginx_service_custom = false,
  String $nginx_service_custom_file = '{{ role_path }}/files/services/nginx.override.conf',
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
  $playbook_path = "${vardir}/lib/puppet_x/ansible_modules/nginxinc_nginx_core/roles/nginx/playbook.yml"

  par { 'paw_nginxinc_nginx_core_nginx-main':
    ensure        => present,
    playbook      => $playbook_path,
    playbook_vars => {
      'path'                               => $path,
      'option'                             => $option,
      'nginx_service_timeoutstartsec'      => $nginx_service_timeoutstartsec,
      'nginx_service_timeoutstopsec'       => $nginx_service_timeoutstopsec,
      'nginx_service_restart'              => $nginx_service_restart,
      'nginx_service_restartsec'           => $nginx_service_restartsec,
      'nginx_amplify_enable'               => $nginx_amplify_enable,
      'nginx_amplify_api_key'              => $nginx_amplify_api_key,
      'nginx_bsd_install_packages'         => $nginx_bsd_install_packages,
      'nginx_bsd_update_ports'             => $nginx_bsd_update_ports,
      'nginx_bsd_portinstall_use_packages' => $nginx_bsd_portinstall_use_packages,
      'nginx_logrotate_conf_enable'        => $nginx_logrotate_conf_enable,
      'nginx_logrotate_conf'               => $nginx_logrotate_conf,
      'nginx_enable'                       => $nginx_enable,
      'nginx_debug_output'                 => $nginx_debug_output,
      'nginx_type'                         => $nginx_type,
      'nginx_start'                        => $nginx_start,
      'nginx_setup'                        => $nginx_setup,
      'nginx_manage_repo'                  => $nginx_manage_repo,
      'nginx_install_from'                 => $nginx_install_from,
      'nginx_install_source_build_tools'   => $nginx_install_source_build_tools,
      'nginx_install_source_pcre'          => $nginx_install_source_pcre,
      'nginx_install_source_openssl'       => $nginx_install_source_openssl,
      'nginx_install_source_zlib'          => $nginx_install_source_zlib,
      'nginx_static_modules'               => $nginx_static_modules,
      'nginx_branch'                       => $nginx_branch,
      'nginx_license'                      => $nginx_license,
      'nginx_setup_license'                => $nginx_setup_license,
      'nginx_remove_license'               => $nginx_remove_license,
      'nginx_install_epel_release'         => $nginx_install_epel_release,
      'nginx_modules'                      => $nginx_modules,
      'nginx_selinux'                      => $nginx_selinux,
      'nginx_selinux_enforcing'            => $nginx_selinux_enforcing,
      'nginx_selinux_tempdir'              => $nginx_selinux_tempdir,
      'nginx_service_modify'               => $nginx_service_modify,
      'nginx_service_clean'                => $nginx_service_clean,
      'nginx_service_overridepath'         => $nginx_service_overridepath,
      'nginx_service_overridefilename'     => $nginx_service_overridefilename,
      'nginx_service_custom'               => $nginx_service_custom,
      'nginx_service_custom_file'          => $nginx_service_custom_file,
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
