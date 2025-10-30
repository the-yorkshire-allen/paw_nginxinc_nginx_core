# paw_nginxinc_nginx_core

## Description

This Puppet module was Converted from Ansible collection: **nginxinc.nginx_core**

Install and configure NGINX and NGINX App Protect using Ansible

## Conversion Details

- **Converted on**: 2025-10-30
- **Original Collection**: nginxinc.nginx_core v0.8.0
- **Authors**: Alessandro Fael Garcia <a.faelgarcia@f5.com>
- **License**: 

## Roles Included

This collection includes the following roles:

- **nginx_app_protect**: Use `include paw_nginxinc_nginx_core::nginx_app_protect`
- **nginx**: Use `include paw_nginxinc_nginx_core::nginx`
- **nginx_config**: Use `include paw_nginxinc_nginx_core::nginx_config`

## Usage

Include specific roles from the collection:

```puppet
include paw_nginxinc_nginx_core::nginx_app_protect
include paw_nginxinc_nginx_core::nginx
```

Or use classes with parameters:

```puppet
class { 'paw_nginxinc_nginx_core::nginx_app_protect':
  # Add your parameters here
}
```

## Parameters

See individual class files in `manifests/` for available parameters.

## Requirements

- Puppet 6.0 or higher
- puppet_agent_runonce module for task execution
- Ansible installed on target nodes for task execution

## License


