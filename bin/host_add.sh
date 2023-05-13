#!/bin/sh

hostname=$1
wireguard_ip=$2
wireguard_endpoint_ip=$3

if [ ! -f host_vars/$hostname.yml ]; then
    public_key=`wg genkey | tr -d '\n' | tee $hostname.key | wg pubkey`
    private_key=`ansible-vault encrypt_string --vault-password-file ./.vault_password --encrypt-vault-id default --output - < $hostname.key`
    rm -f $hostname.key

    cat << EOF > host_vars/$hostname.yml
---
wireguard_ip: $wireguard_ip
wireguard_private_key: $private_key
wireguard_public_key: $public_key
EOF

  if [ ! -z "$wireguard_endpoint_ip" ]; then
    echo "wireguard_endpoint: $wireguard_endpoint_ip:51820" >> host_vars/$hostname.yml
  fi
fi

if [ ! -f $hostname.yml ]; then
    cat << EOF > $hostname.yml
---
- name: $hostname setup
  hosts: $hostname
  become: yes

  roles:
    - apt_update
EOF
fi
