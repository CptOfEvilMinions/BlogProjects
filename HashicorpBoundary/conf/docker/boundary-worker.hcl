# Disable memory lock: https://www.man7.org/linux/man-pages/man2/mlock.2.html
disable_mlock = {{ disable_mlock }}

##################################################################################################
# Boudnary worker
##################################################################################################
worker {
  name = "{{ base_domain }}-{{ hostname }}-worker"
  description = "{{ base_domain }} Boundary worker"

  controllers = [
    "172.16.238.10"
  ]

  public_addr = "{{ ipify_public_ip }}"

}

##################################################################################################
# Boudnary listener
##################################################################################################
listener "tcp" {
  purpose = "proxy"
  tls_disable = {{ tls_disable }}
  address = "0.0.0.0"
}

##################################################################################################
# Boudnary KMS
##################################################################################################
# must be same key as used on controller config
kms "transit" {
  purpose            = "worker-auth"
  address            = "{{ vault_addr }}"
  token              = "{{ vault_kms_worker_token }}"
  disable_renewal    = "false"

  // Key configuration
  key_name           = "boundary-worker-key"
  mount_path         = "{{ vault_kms_mount_path }}"
  namespace          = "keys/"

  // TLS Configuration
  tls_ca_cert        = "/etc/ssl/certs/{{ base_domain | replace('.','-') }}-root-ca.crt"
  tls_server_name    = "vault.{{ base_domain }}"
  tls_skip_verify    = "false"
}
