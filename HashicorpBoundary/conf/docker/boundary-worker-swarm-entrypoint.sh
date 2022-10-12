#!/bin/ash

set -e

echo "[+] - $(date) - Starting Boundary controller"

################################# Download Vault root CA #################################
echo "[+] - $(date) - Retrieving Vault root CA"
# Get Vault root CA
wget --no-check-certificate ${VAULT_ADDR}/v1/pki/ca/pem -O /boundary/${BASE_DOMAIN//./-}-root-ca.crt && \
    chown root:root /boundary/${BASE_DOMAIN//./-}-root-ca.crt && \
    chmod 644 /boundary/${BASE_DOMAIN//./-}-root-ca.crt

################################# Configure Boundary #################################
echo "[+] - $(date) - Configure Boundary controller"

# Copy config from temp to boundary directory
cp /tmp/boundary-worker.hcl /boundary/worker.hcl

# Wait until controller is accessible
nslookup controller
while [ $? -ne 0 ]; do !!; done

# Set config vaules
sed -i "s#{{ base_domain }}#${BASE_DOMAIN}#g" /boundary/worker.hcl && \
    # Set Controller name
    sed -i "s#name = \".*#name = \"${BASE_DOMAIN}-$(hostname)-worker\"#g" /boundary/worker.hcl && \
    # Set mlock
    sed -i "s#{{ disable_mlock }}#${DISABLE_MLOCK}#g" /boundary/worker.hcl && \
    # Set tls_disable
    sed -i "s#{{ tls_disable }}#${TLS_DISABLE}#g" /boundary/worker.hcl && \
    # Set root CA file name
    sed -i "s#tls_ca_cert        = \"/etc/ssl/certs.*#tls_ca_cert        = \"/boundary/${BASE_DOMAIN//./-}-root-ca.crt\"#g" /boundary/worker.hcl && \
    # Set Vault addr
    sed -i "s#{{ vault_addr }}#${VAULT_ADDR}#g" /boundary/worker.hcl && \
    # Set Vault KMS mount path
    sed -i "s#{{ vault_kms_mount_path }}#${VAULT_MOUNT_PATH}#g" /boundary/worker.hcl && \
    # Set Vault KMS tokens
    sed -i "s#{{ vault_kms_worker_token }}#$(cat /run/secrets/vault-kms-worker-token)#g" /boundary/worker.hcl && \
    # Set public IP
    sed -i "s#{{ ipify_public_ip }}#$(wget -qO- ifconfig.me)#g" /boundary/worker.hcl && \
    # Set controller IP addr
    sed -i "s#{{ controller_ip_addr }}#$(nslookup controller | grep 'Address 1' | awk '{print $3}')#g" /boundary/worker.hcl


# Pass command line arguments to boundary command
echo "[+] - $(date) - Starting Boundary worker"
/bin/boundary server -config /boundary/worker.hcl
