# paw_nginxinc_nginx_core::nginx_config
# @summary Manage paw_nginxinc_nginx_core configuration
#
# @param module
# @param connection
# @param address
# @param signature
# @param allow
# @param deny
# @param file
# @param directive
# @param header
# @param command
# @param condition
# @param certificate
# @param key
# @param ansible_managed
# @param nginx_config_start
# @param nginx_config_debug_output
# @param nginx_config_cleanup
# @param nginx_config_selinux
# @param nginx_config_selinux_enforcing
# @param nginx_config_html_demo_template_enable
# @param nginx_config_html_demo_template
# @param nginx_config_main_template_enable
# @param nginx_config_main_template
# @param nginx_config_http_template_enable
# @param nginx_config_http_template
# @param nginx_config_status_enable
# @param nginx_config_status_template_file
# @param nginx_config_status_file_location
# @param nginx_config_status_backup
# @param nginx_config_status_port
# @param nginx_config_status_access_log
# @param nginx_config_status_allow
# @param nginx_config_status_deny
# @param nginx_config_rest_api_enable
# @param nginx_config_rest_api_template_file
# @param nginx_config_rest_api_file_location
# @param nginx_config_rest_api_backup
# @param nginx_config_rest_api_port
# @param nginx_config_rest_api_write
# @param nginx_config_rest_api_access_log
# @param nginx_config_rest_api_allow
# @param nginx_config_rest_api_deny
# @param nginx_config_rest_api_dashboard
# @param nginx_config_rest_api_dashboard_allow
# @param nginx_config_rest_api_dashboard_deny
# @param nginx_config_stream_template_enable
# @param nginx_config_stream_template
# @param nginx_config_upload_enable
# @param nginx_config_upload
# @param nginx_config_upload_html_enable
# @param nginx_config_upload_html
# @param nginx_config_upload_ssl_enable
# @param nginx_config_upload_ssl_crt
# @param nginx_config_upload_ssl_key
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
class paw_nginxinc_nginx_core::nginx_config (
  Optional[String] $module = undef,
  Optional[String] $connection = undef,
  Optional[String] $address = undef,
  Optional[String] $signature = undef,
  Optional[String] $allow = undef,
  Optional[String] $deny = undef,
  Optional[String] $file = undef,
  Optional[String] $directive = undef,
  Optional[String] $header = undef,
  Optional[String] $command = undef,
  Optional[String] $condition = undef,
  Optional[String] $certificate = undef,
  Optional[String] $key = undef,
  Optional[String] $ansible_managed = undef,
  Boolean $nginx_config_start = true,
  Boolean $nginx_config_debug_output = false,
  Boolean $nginx_config_cleanup = false,
  Boolean $nginx_config_selinux = false,
  Boolean $nginx_config_selinux_enforcing = true,
  Boolean $nginx_config_html_demo_template_enable = false,
  Array $nginx_config_html_demo_template = [{ 'template_file' => 'www/index.html.j2', 'deployment_location' => '/usr/share/nginx/html/index.html', 'web_server_name' => 'Default', 'backup' => true }],
  Boolean $nginx_config_main_template_enable = false,
  Hash $nginx_config_main_template = { 'template_file' => 'nginx.conf.j2', 'deployment_location' => '/etc/nginx/nginx.conf', 'backup' => true, 'config' => { 'main' => { 'user' => { 'username' => 'nginx', 'group' => 'nginx' }, 'worker_processes' => 'auto', 'error_log' => { 'file' => '/var/log/nginx/error.log', 'level' => 'notice' }, 'pid' => '/var/run/nginx.pid', 'daemon' => true }, 'events' => { 'worker_connections' => 1024 }, 'http' => { 'include' => ['/etc/nginx/mime.types', '/etc/nginx/conf.d/*.conf'] } } },
  Boolean $nginx_config_http_template_enable = false,
  Array $nginx_config_http_template = [{ 'template_file' => 'http/default.conf.j2', 'deployment_location' => '/etc/nginx/conf.d/default.conf', 'backup' => true, 'config' => { 'upstreams' => [{ 'name' => 'backend', 'servers' => [{ 'address' => 'localhost', 'weight' => 1, 'max_conns' => 0, 'max_fails' => 1, 'fail_timeout' => '10s', 'backup' => false, 'down' => false, 'resolve' => false, 'service' => 'http', 'route' => 'a', 'slow_start' => '0s', 'drain' => false }], 'zone' => { 'name' => 'backend_mem_zone', 'size' => '64k' }, 'state' => '/var/lib/nginx/state/servers.conf', 'hash' => { 'key' => 'key', 'consistent' => false }, 'ip_hash' => false, 'least_conn' => false, 'least_time' => { 'response' => 'last_byte', 'inflight' => false }, 'random' => { 'two' => true, 'method' => 'least_time=last_byte' }, 'queue' => { 'number' => 10, 'timeout' => '60s' }, 'keepalive' => 32, 'keepalive_requests' => 100, 'keepalive_time' => '1h', 'keepalive_timeout' => '60s', 'ntlm' => false, 'resolver' => { 'address' => [], 'valid' => '30s', 'ipv6' => false, 'status_zone' => 'backend_mem_zone' }, 'resolver_timeout' => '30s', 'sticky_cookie' => { 'name' => 'cookie', 'expires' => '1d', 'domain' => 'example.com', 'httponly' => false, 'samesite' => 'none', 'secure' => true, 'path' => 'path' }, 'sticky_route' => [], 'sticky_learn' => { 'create' => [], 'lookup' => [], 'zone' => { 'name' => 'client_sessions', 'size' => '1m' }, 'timeout' => '10m', 'header' => false, 'sync' => false } }], 'core' => { 'absolute_redirect' => true, 'aio' => { 'threads' => true }, 'aio_write' => false, 'alias' => 'path', 'auth_delay' => '0s', 'chunked_transfer_encoding' => true, 'client_body_buffer_size' => '8k', 'client_body_in_file_only' => false, 'client_body_in_single_buffer' => false, 'client_body_temp_path' => { 'path' => '/var/cache/nginx', 'level' => 2 }, 'client_body_timeout' => '60s', 'client_header_buffer_size' => '1k', 'client_header_timeout' => '60s', 'client_max_body_size' => '1m', 'connection_pool_size' => 256, 'default_type' => 'text/plain', 'directio' => false, 'directio_alignment' => 512, 'disable_symlinks' => { 'check' => 'on', 'from' => '$document_root' }, 'error_page' => [{ 'code' => [404], 'response' => 404, 'uri' => '/404.html' }], 'etag' => true, 'if_modified_since' => 'exact', 'ignore_invalid_headers' => true, 'include' => 'path', 'internal' => false, 'keepalive_disable' => 'msie6', 'keepalive_requests' => 1000, 'keepalive_time' => '1h', 'keepalive_timeout' => { 'timeout' => '75s', 'header_timeout' => '75s' }, 'large_client_header_buffers' => { 'number' => 4, 'size' => '8k' }, 'limit_except' => { 'method' => 'GET', 'directive' => ['allow all'] }, 'limit_rate' => 0, 'limit_rate_after' => 0, 'lingering_close' => true, 'lingering_time' => '30s', 'lingering_timeout' => '5s', 'listen' => [{ 'address' => '0.0.0.0', 'port' => 80, 'default_server' => true, 'ssl' => false, 'http2' => false, 'spdy' => false, 'proxy_protocol' => false, 'fastopen' => 12, 'backlog' => 511, 'rcvbuf' => 512, 'sndbuf' => 512, 'deffered' => false, 'bind' => false, 'ipv6only' => false, 'reuseport' => false, 'so_keepalive' => { 'keepidle' => '30m', 'keepintvl' => 5, 'keepcnt' => 10 } }], 'log_not_found' => true, 'log_subrequest' => false, 'max_ranges' => 0, 'merge_slashes' => true, 'msie_padding' => true, 'msie_refresh' => false, 'open_file_cache' => { 'max' => 10, 'inactive' => '60s' }, 'open_file_cache_errors' => false, 'open_file_cache_min_uses' => 1, 'open_file_cache_valid' => '60s', 'output_buffers' => { 'number' => 2, 'size' => '32k' }, 'port_in_redirect' => true, 'postpone_output' => 1460, 'read_ahead' => 0, 'recursive_error_pages' => false, 'request_pool_size' => '4k', 'reset_timedout_connection' => false, 'resolver' => { 'address' => '127.0.0.1', 'valid' => '60s', 'ipv6' => false, 'status_zone' => 'zone' }, 'resolver_timeout' => '30s', 'root' => 'html', 'index' => 'path', 'satisfy' => 'all', 'send_lowat' => 0, 'send_timeout' => '60s', 'sendfile' => false, 'sendfile_max_chunk' => 0, 'server_name' => '', 'server_name_in_redirect' => false, 'server_names_hash_bucket_size' => 32, 'server_names_hash_max_size' => 512, 'server_tokens' => true, 'subrequest_output_buffer_size' => '4k', 'tcp_nodelay' => true, 'tcp_nopush' => false, 'try_files' => { 'files' => '$uri', 'uri' => '/uri', 'code' => 'code' }, 'types' => [{ 'mime' => 'text/html', 'extensions' => 'html' }], 'types_hash_bucket_size' => 64, 'types_hash_max_size' => 1024, 'underscores_in_headers' => false, 'variables_hash_bucket_size' => 64, 'variables_hash_max_size' => 1024 }, 'ssl' => { 'buffer_size' => '16k', 'certificate' => '/path/to/file', 'certificate_key' => '/path/to/file', 'ciphers' => 'HIGH', 'client_certificate' => '/path/to/file', 'conf_command' => 'command', 'crl' => '/path/to/file', 'dhparam' => '/path/to/file', 'early_data' => false, 'ecdh_curve' => 'auto', 'ocsp' => false, 'ocsp_cache' => { 'name' => 'cache', 'size' => '16k' }, 'ocsp_responder' => '<url>', 'password_file' => '/path/to/file', 'prefer_server_ciphers' => false, 'protocols' => 'TLSv1', 'reject_handshake' => false, 'session_cache' => { 'builtin' => { 'enable' => false, 'size' => '16k' } }, 'session_ticket_key' => '/path/to/file', 'session_tickets' => true, 'session_timeout' => '5m', 'stapling' => false, 'stapling_file' => '/path/to/file', 'stapling_responder' => '<url>', 'stapling_verify' => false, 'trusted_certificate' => '/path/to/file', 'verify_client' => false, 'verify_depth' => 1 }, 'app_protect_waf' => { 'physical_memory_util_thresholds' => { 'high' => 100, 'low' => 100 }, 'cpu_thresholds' => { 'high' => 100, 'low' => 100 }, 'failure_mode_action' => 'pass', 'cookie_seed' => 'encryptionseed', 'compressed_requests_action' => 'drop', 'reconnect_period_seconds' => 5, 'request_buffer_overflow_action' => 'pass', 'user_defined_signatures' => '/path/to/file', 'enable' => false, 'policy_file' => '/path/to/file', 'security_log_enable' => false, 'security_log' => [{ 'path' => '/path/to/file', 'dest' => 'dest' }] }, 'app_protect_dos' => { 'enable' => true, 'policy_file' => '/etc/app_protect/conf/BADOSDefaultPolicy.json', 'name' => 'samplename', 'monitor' => { 'uri' => 'http://10.1.1.1:5000/monitor', 'protocol' => 'http2', 'timeout' => 10 }, 'security_log_enable' => true, 'security_log' => { 'path' => '/etc/app_protect_dos/log-default.json', 'dest' => 'syslog:server=10.1.1.1:514' }, 'liveness' => { 'enable' => true, 'uri' => 'example.com', 'port' => 80 }, 'readiness' => { 'enable' => true, 'uri' => 'example.com', 'port' => 80 }, 'arb_fqdn' => '192.168.1.10', 'api' => false, 'accelerated_mitigation' => false }, 'proxy' => { 'bind' => { 'address' => '0.0.0.0', 'transparent' => false }, 'buffer_size' => '4k', 'buffering' => true, 'buffers' => { 'number' => 8, 'size' => '4k' }, 'busy_buffers_size' => '8k', 'cache' => false, 'cache_background_update' => false, 'cache_bypass' => '$cookie_seed', 'cache_convert_head' => true, 'cache_key' => '$scheme$proxy_host$request_uri', 'cache_lock' => false, 'cache_lock_age' => '5s', 'cache_lock_timeout' => '5s', 'cache_max_range_offset' => 1, 'cache_methods' => 'GET', 'cache_min_uses' => 1, 'cache_path' => [{ 'path' => '/var/cache/nginx/proxy/backend', 'levels' => '1:1', 'use_temp_path' => false, 'keys_zone' => { 'name' => 'backend_proxy_cache', 'size' => '10m' }, 'inactive' => '10m', 'max_size' => '2g', 'min_free' => '1g', 'manager_files' => 100, 'manager_sleep' => '500ms', 'manager_threshold' => '200ms', 'loader_files' => 100, 'loader_sleep' => '50ms', 'loader_threshold' => '200ms', 'purger' => false, 'purger_files' => 10, 'purger_sleep' => '50ms', 'purger_threshold' => '50ms' }], 'cache_purge' => 'sample', 'cache_revalidate' => false, 'cache_use_stale' => false, 'cache_valid' => [{ 'code' => 200, 'time' => '10m' }, '2m'], 'connect_timeout' => '60s', 'cookie_domain' => [{ 'domain' => 'localhost', 'replacement' => 'example.org' }], 'cookie_flags' => { 'cookie' => 'one', 'flag' => ['httponly'] }, 'cookie_path' => [{ 'path' => '$uri', 'replacement' => '$someuri' }], 'force_ranges' => false, 'headers_hash_bucket_size' => 64, 'headers_hash_max_size' => 512, 'hide_header' => 'Date', 'http_version' => '1.1', 'ignore_client_abort' => false, 'ignore_headers' => 'X-Accel-Redirect', 'intercept_errors' => false, 'limit_rate' => 0, 'max_temp_file_size' => '1024m', 'method' => 'GET', 'next_upstream' => false, 'next_upstream_timeout' => 0, 'next_upstream_tries' => 0, 'no_cache' => '$cookie_nocache', 'pass' => 'http://127.0.0.1', 'pass_header' => 'Date', 'pass_request_body' => false, 'pass_request_headers' => true, 'read_timeout' => '60s', 'redirect' => { 'original' => 'http://upstream:port/two/', 'replacement' => '/one/' }, 'request_buffering' => false, 'send_lowat' => 0, 'send_timeout' => '60s', 'set_body' => 'body', 'set_header' => { 'field' => 'Host', 'value' => '$proxy_host' }, 'socket_keepalive' => false, 'ssl_certificate' => '/path/to/file', 'ssl_certificate_key' => '/path/to/file', 'ssl_ciphers' => 'DEFAULT', 'ssl_conf_command' => 'command', 'ssl_crl' => '/path/to/file', 'ssl_name' => '$proxy_host', 'ssl_password_file' => '/path/to/file', 'ssl_protocols' => 'TLSv1', 'ssl_server_name' => false, 'ssl_session_reuse' => true, 'ssl_trusted_certificate' => '/path/to/file', 'ssl_verify' => false, 'ssl_verify_depth' => 1, 'store' => false, 'store_access' => { 'user' => 'rw', 'group' => 'rw', 'all' => 'r' }, 'temp_file_write_size' => '8k', 'temp_path' => { 'path' => '/var/cache/nginx/proxy/temp', 'level' => 2 } }, 'grpc' => { 'bind' => { 'address' => '$remote_addr', 'transparent' => true }, 'buffer_size' => '4k', 'connect_timeout' => '60s', 'hide_header' => [], 'ignore_headers' => [], 'intercept_errors' => false, 'next_upstream' => [], 'next_upstream_timeout' => 0, 'next_upstream_tries' => 0, 'pass' => 'uri', 'pass_header' => [], 'read_timeout' => '60s', 'send_timeout' => '60s', 'set_header' => [{ 'field' => 'Accept-Encoding', 'value' => '""' }], 'socket_keepalive' => false, 'ssl_certificate' => '/path/to/file', 'ssl_certificate_key' => '/path/to/file', 'ssl_ciphers' => 'DEFAULT', 'ssl_conf_command' => 'command', 'ssl_crl' => '/path/to/file', 'ssl_name' => 'serverName', 'ssl_password_file' => '/path/to/file', 'ssl_protocols' => [], 'ssl_server_name' => false, 'ssl_session_reuse' => true, 'ssl_trusted_certificate' => '/path/to/file', 'ssl_verify' => false, 'ssl_verify_depth' => 1 }, 'access' => { 'allow' => 'localhost', 'deny' => '192.168.1.100' }, 'auth_basic' => { 'realm' => false, 'user_file' => '/path/to/file' }, 'auth_request' => { 'uri' => false, 'set' => { 'variable' => '$temp', 'value' => 'auth' } }, 'auth_jwt' => { 'enable' => { 'realm' => 'realm', 'token' => '$cookie_auth_token' }, 'claim_set' => [{ 'variable' => '$email', 'name' => ['info'] }], 'header_set' => [{ 'variable' => '$job', 'name' => 'info' }], 'key_file' => '/path/to/file', 'key_request' => '/path/to/file', 'leeway' => '0s', 'type' => 'signed', 'require' => { 'values' => '$valid_jwt_iss', 'error' => 401 } }, 'api' => { 'enable' => { 'write' => true }, 'status_zone' => 'one' }, 'stub_status' => true, 'autoindex' => { 'enable' => false, 'exact_size' => true, 'format' => 'html', 'localtime' => false }, 'gunzip' => { 'enable' => true, 'buffers' => { 'number' => 32, 'size' => '4k' } }, 'gzip' => { 'enable' => true, 'buffers' => { 'number' => 32, 'size' => '4k' }, 'comp_level' => 1, 'disable' => [], 'http_version' => '1.1', 'min_length' => 20, 'proxied' => [], 'types' => [], 'vary' => false }, 'headers' => { 'add_headers' => [{ 'name' => 'Strict-Transport-Security', 'value' => '"max-age=15768000; includeSubDomains"', 'always' => false }], 'add_trailers' => [{ 'name' => 'Strict-Transport-Security', 'value' => '"max-age=15768000; includeSubDomains"', 'always' => false }], 'expires' => { 'modified' => true, 'time' => '12h' } }, 'health_check' => { 'health_checks' => [{ 'interval' => '5s', 'jitter' => 0, 'fails' => 1, 'passes' => 1, 'uri' => '/', 'mandatory' => false, 'persistent' => false, 'match' => 'match', 'port' => 80, 'grpc_service' => 'service', 'grpc_status' => 12, 'keepalive_time' => 0 }], 'match' => [{ 'name' => 'name', 'conditions' => [] }] }, 'keyval' => { 'keyvals' => [{ 'key' => 'key', 'variable' => '$var', 'zone' => 'one' }], 'zones' => [{ 'name' => 'one', 'size' => '32k', 'state' => '/var/lib/nginx/state/one.keyval', 'timeout' => '60m', 'type' => 'string', 'sync' => false }] }, 'limit_req' => { 'limit_reqs' => [{ 'zone' => 'one', 'burst' => 5, 'delay' => false }], 'dry_run' => false, 'log_level' => 'error', 'status' => 503, 'zones' => [{ 'key' => '$binary_remote_addr', 'name' => 'one', 'size' => '1m', 'rate' => '10r/s', 'sync' => false }] }, 'log' => { 'format' => [{ 'name' => 'main', 'escape' => 'default', 'format' => '\'$remote_addr - $remote_user [$time_local] "$request" \'\n\'$status $body_bytes_sent "$http_referer" \'\n\'"$http_user_agent" "$http_x_forwarded_for"\'\n' }], 'access' => [{ 'path' => '/var/log/nginx/access.log', 'format' => 'main', 'buffer' => '1m', 'gzip' => 5, 'flush' => '10h', 'if' => '$loggable' }], 'error' => { 'file' => '/var/log/nginx/error.log', 'level' => 'notice' }, 'open_log_file_cache' => { 'max' => 1000, 'inactive' => '20s', 'min_uses' => 2, 'valid' => '1m' } }, 'map' => { 'hash_bucket_size' => 64, 'hash_max_size' => 2048, 'mappings' => { 'string' => '$remote_addr', 'variable' => '$upstream', 'hostnames' => false, 'volatile' => false, 'content' => [{ 'value' => 'default', 'new_value' => 0 }] } }, 'mirror' => { 'request_body' => true, 'uri' => false }, 'realip' => { 'set_real_ip_from' => '0.0.0.0', 'real_ip_header' => 'X-Real-IP', 'real_ip_recursive' => false }, 'rewrite' => { 'return' => { 'code' => 200, 'text' => 'text', 'url' => 'https://example.com' }, 'rewrites' => [{ 'regex' => '(.*).html(.*)', 'replacement' => '$1$2', 'flag' => 'last' }], 'log' => false, 'set' => [{ 'variable' => '$var', 'value' => 'var' }], 'uninitialized_variable_warn' => true }, 'split_clients' => { 'string' => '$remote_addr', 'variable' => '$upstream', 'content' => [{ 'percentage' => '20%', 'value' => 'appv2' }, { 'percentage' => '*', 'value' => 'app' }] }, 'sub_filter' => { 'sub_filters' => [{ 'string' => 'server_hostname', 'replacement' => '$hostname' }], 'last_modified' => false, 'once' => true, 'types' => 'text/html' }, 'custom_directives' => ['fastcgi_split_path_info ^(.+\\.php)(/.+)$;', 'fastcgi_pass unix:/run/php/php7.2-fpm.sock;'], 'servers' => [{ 'core' => undef, 'proxy' => undef, 'locations' => [{ 'location' => '/', 'proxy' => undef }] }, { 'core' => undef, 'ssl' => undef, 'locations' => [{ 'location' => '/backend', 'core' => undef }] }] } }],
  Boolean $nginx_config_status_enable = false,
  String $nginx_config_status_template_file = 'http/status.conf.j2',
  String $nginx_config_status_file_location = '/etc/nginx/conf.d/status.conf',
  Boolean $nginx_config_status_backup = true,
  Integer $nginx_config_status_port = 8080,
  Hash $nginx_config_status_access_log = { 'path' => '/var/log/nginx/access.log', 'format' => 'main' },
  Array $nginx_config_status_allow = ['127.0.0.1'],
  Array $nginx_config_status_deny = ['all'],
  Boolean $nginx_config_rest_api_enable = false,
  String $nginx_config_rest_api_template_file = 'http/api.conf.j2',
  String $nginx_config_rest_api_file_location = '/etc/nginx/conf.d/api.conf',
  Boolean $nginx_config_rest_api_backup = true,
  Integer $nginx_config_rest_api_port = 8080,
  Boolean $nginx_config_rest_api_write = false,
  Hash $nginx_config_rest_api_access_log = { 'path' => '/var/log/nginx/access.log', 'format' => 'main' },
  Array $nginx_config_rest_api_allow = ['127.0.0.1'],
  Array $nginx_config_rest_api_deny = ['all'],
  Boolean $nginx_config_rest_api_dashboard = false,
  Array $nginx_config_rest_api_dashboard_allow = ['127.0.0.1'],
  Array $nginx_config_rest_api_dashboard_deny = ['all'],
  Boolean $nginx_config_stream_template_enable = false,
  Array $nginx_config_stream_template = [{ 'template_file' => 'stream/default.conf.j2', 'deployment_location' => '/etc/nginx/conf.d/streams/stream_default.conf', 'config' => { 'upstreams' => [{ 'name' => 'stream_upstream', 'servers' => [{ 'address' => '0.0.0.0:9091', 'weight' => 1, 'max_conns' => 100, 'max_fails' => 3, 'fail_timeout' => '5s', 'backup' => false, 'down' => false, 'resolve' => false, 'service' => 'http', 'slow_start' => '0s' }], 'zone' => { 'name' => 'stream_zone', 'size' => '64k' }, 'state' => '/var/lib/nginx/state/servers.conf', 'hash' => { 'key' => 'key', 'consistent' => false }, 'least_conn' => false, 'least_time' => { 'response' => 'last_byte', 'inflight' => false }, 'random' => { 'two' => true, 'method' => 'least_time=last_byte' }, 'resolver' => { 'address' => [], 'valid' => '30s', 'ipv6' => false, 'status_zone' => 'backend_mem_zone' }, 'resolver_timeout' => '30s' }], 'core' => { 'include' => 'path', 'listen' => [{ 'address' => '0.0.0.0', 'port' => 80, 'ssl' => false, 'udp' => false, 'proxy_protocol' => false, 'fastopen' => 12, 'backlog' => 511, 'rcvbuf' => 512, 'sndbuf' => 512, 'bind' => false, 'ipv6only' => false, 'reuseport' => false, 'so_keepalive' => { 'keepidle' => '30m', 'keepintvl' => 5, 'keepcnt' => 10 } }], 'preread_buffer_size' => '16k', 'preread_timeout' => '30s', 'proxy_protocol_timeout' => '30s', 'resolver' => { 'address' => '127.0.0.1', 'valid' => '60s', 'ipv6' => false, 'status_zone' => 'zone' }, 'resolver_timeout' => '30s', 'tcp_nodelay' => true, 'variables_hash_bucket_size' => 64, 'variables_hash_max_size' => 1024 }, 'ssl' => { 'alpn' => 'http/1.1', 'certificate' => '/etc/ssl/certs/molecule.crt', 'certificate_key' => '/etc/ssl/private/molecule.key', 'ciphers' => ['HIGH', '!aNull', '!MD5'], 'client_certificate' => '/path/to/file', 'conf_command' => 'Protocol TLSv1.2', 'crl' => '/path/to/file', 'dhparam' => '/path/to/file', 'ecdh_curve' => 'auto', 'handshake_timeout' => '60s', 'password_file' => '/path/to/file', 'prefer_server_ciphers' => false, 'protocols' => ['TLSv1', 'TLSv1.1', 'TLSv1.2'], 'session_cache' => { 'builtin' => { 'enable' => false, 'size' => '16k' } }, 'session_ticket_key' => '/path/to/file', 'session_tickets' => true, 'session_timeout' => '5m', 'trusted_certificate' => '/path/to/file', 'verify_client' => false, 'verify_depth' => 1 }, 'proxy' => { 'bind' => { 'address' => '0.0.0.0', 'transparent' => false }, 'buffer_size' => '4k', 'connect_timeout' => '60s', 'download_rate' => 0, 'half_close' => false, 'next_upstream' => true, 'next_upstream_timeout' => 0, 'next_upstream_tries' => 0, 'pass' => '127.0.0.1', 'protocol' => false, 'requests' => 0, 'responses' => 0, 'session_drop' => false, 'socket_keepalive' => false, 'ssl' => false, 'ssl_certificate' => '/path/to/file', 'ssl_certificate_key' => '/path/to/file', 'ssl_ciphers' => 'HIGH', 'ssl_conf_command' => ['Protocol TLSv1.2'], 'ssl_crl' => '/path/to/file', 'ssl_name' => '$hostname', 'ssl_password_file' => '/path/to/file', 'ssl_protocols' => 'TLSv1.2', 'ssl_server_name' => false, 'ssl_session_reuse' => true, 'ssl_trusted_certificate' => '/path/to/file', 'ssl_verify' => false, 'ssl_verify_depth' => 1, 'timeout' => '10m', 'upload_rate' => 0 }, 'health_check' => { 'health_checks' => [{ 'interval' => '5s', 'jitter' => 0, 'fails' => 1, 'passes' => 1, 'uri' => '/', 'mandatory' => false, 'persistent' => false, 'match' => 'match', 'port' => 80, 'udp' => false }], 'match' => [{ 'name' => 'nginx_stream', 'conditions' => ['status 200'] }], 'timeout' => '60s' }, 'keyval' => { 'keyvals' => [{ 'key' => 'key', 'variable' => '$var', 'zone' => 'one' }], 'zones' => [{ 'name' => 'one', 'size' => '32k', 'state' => '/var/lib/nginx/state/one.keyval', 'timeout' => '60m', 'type' => 'string', 'sync' => false }] }, 'log' => { 'format' => [{ 'name' => 'main', 'escape' => 'default', 'format' => '\'$remote_addr - $remote_user [$time_local] "$request" \'\n\'$status $body_bytes_sent "$http_referer" \'\n\'"$http_user_agent" "$http_x_forwarded_for"\'\n' }], 'access' => [{ 'path' => '/var/log/nginx/access.log', 'format' => 'main', 'buffer' => '1m', 'gzip' => 5, 'flush' => '10h', 'if' => '$loggable' }], 'error' => { 'file' => '/var/log/nginx/error.log', 'level' => 'notice' }, 'open_log_file_cache' => { 'max' => 1000, 'inactive' => '20s', 'min_uses' => 2, 'valid' => '1m' } }, 'custom_directives' => ['server {};'], 'servers' => [{ 'core' => undef, 'proxy' => undef }] } }],
  Boolean $nginx_config_upload_enable = false,
  Array $nginx_config_upload = [{ 'src' => 'config/snippets/', 'dest' => '/etc/nginx/snippets', 'backup' => true }],
  Boolean $nginx_config_upload_html_enable = false,
  Array $nginx_config_upload_html = [{ 'src' => 'www/index.html', 'dest' => '/usr/share/nginx/html', 'backup' => true }],
  Boolean $nginx_config_upload_ssl_enable = false,
  Array $nginx_config_upload_ssl_crt = [{ 'src' => 'ssl/certs/', 'dest' => '/etc/ssl/certs', 'backup' => true }],
  Array $nginx_config_upload_ssl_key = [{ 'src' => 'ssl/private/', 'dest' => '/etc/ssl/private', 'backup' => true }],
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
  $playbook_path = "${vardir}/lib/puppet_x/ansible_modules/nginxinc_nginx_core/roles/nginx_config/playbook.yml"

  par { 'paw_nginxinc_nginx_core_nginx_config-main':
    ensure        => present,
    playbook      => $playbook_path,
    playbook_vars => {
      'module'                                 => $module,
      'connection'                             => $connection,
      'address'                                => $address,
      'signature'                              => $signature,
      'allow'                                  => $allow,
      'deny'                                   => $deny,
      'file'                                   => $file,
      'directive'                              => $directive,
      'header'                                 => $header,
      'command'                                => $command,
      'condition'                              => $condition,
      'certificate'                            => $certificate,
      'key'                                    => $key,
      'ansible_managed'                        => $ansible_managed,
      'nginx_config_start'                     => $nginx_config_start,
      'nginx_config_debug_output'              => $nginx_config_debug_output,
      'nginx_config_cleanup'                   => $nginx_config_cleanup,
      'nginx_config_selinux'                   => $nginx_config_selinux,
      'nginx_config_selinux_enforcing'         => $nginx_config_selinux_enforcing,
      'nginx_config_html_demo_template_enable' => $nginx_config_html_demo_template_enable,
      'nginx_config_html_demo_template'        => $nginx_config_html_demo_template,
      'nginx_config_main_template_enable'      => $nginx_config_main_template_enable,
      'nginx_config_main_template'             => $nginx_config_main_template,
      'nginx_config_http_template_enable'      => $nginx_config_http_template_enable,
      'nginx_config_http_template'             => $nginx_config_http_template,
      'nginx_config_status_enable'             => $nginx_config_status_enable,
      'nginx_config_status_template_file'      => $nginx_config_status_template_file,
      'nginx_config_status_file_location'      => $nginx_config_status_file_location,
      'nginx_config_status_backup'             => $nginx_config_status_backup,
      'nginx_config_status_port'               => $nginx_config_status_port,
      'nginx_config_status_access_log'         => $nginx_config_status_access_log,
      'nginx_config_status_allow'              => $nginx_config_status_allow,
      'nginx_config_status_deny'               => $nginx_config_status_deny,
      'nginx_config_rest_api_enable'           => $nginx_config_rest_api_enable,
      'nginx_config_rest_api_template_file'    => $nginx_config_rest_api_template_file,
      'nginx_config_rest_api_file_location'    => $nginx_config_rest_api_file_location,
      'nginx_config_rest_api_backup'           => $nginx_config_rest_api_backup,
      'nginx_config_rest_api_port'             => $nginx_config_rest_api_port,
      'nginx_config_rest_api_write'            => $nginx_config_rest_api_write,
      'nginx_config_rest_api_access_log'       => $nginx_config_rest_api_access_log,
      'nginx_config_rest_api_allow'            => $nginx_config_rest_api_allow,
      'nginx_config_rest_api_deny'             => $nginx_config_rest_api_deny,
      'nginx_config_rest_api_dashboard'        => $nginx_config_rest_api_dashboard,
      'nginx_config_rest_api_dashboard_allow'  => $nginx_config_rest_api_dashboard_allow,
      'nginx_config_rest_api_dashboard_deny'   => $nginx_config_rest_api_dashboard_deny,
      'nginx_config_stream_template_enable'    => $nginx_config_stream_template_enable,
      'nginx_config_stream_template'           => $nginx_config_stream_template,
      'nginx_config_upload_enable'             => $nginx_config_upload_enable,
      'nginx_config_upload'                    => $nginx_config_upload,
      'nginx_config_upload_html_enable'        => $nginx_config_upload_html_enable,
      'nginx_config_upload_html'               => $nginx_config_upload_html,
      'nginx_config_upload_ssl_enable'         => $nginx_config_upload_ssl_enable,
      'nginx_config_upload_ssl_crt'            => $nginx_config_upload_ssl_crt,
      'nginx_config_upload_ssl_key'            => $nginx_config_upload_ssl_key,
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
