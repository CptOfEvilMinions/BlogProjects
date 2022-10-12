##################################################################################################
# Boudnary worker
##################################################################################################
worker {
  name = "{{ base_domain | replace('.','-') }}-worker"
  description = "{{ base_domain }} Boundary worker"

  controllers = [
    "127.0.0.1"
  ]

  public_addr = "{{ ipify_public_ip }}"

}

##################################################################################################
# Boudnary listener
##################################################################################################
listener "tcp" {
  purpose = "proxy"
  tls_disable = true
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
  tls_server_name    = "{{ vault_addr.rpartition('//')[-1].partition('/')[0].partition(':')[0] }}"
  tls_skip_verify    = "false"
}
