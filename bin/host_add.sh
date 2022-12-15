#!/bin/sh

hostname=$3
wireguard_endpoint_ip=$2
wireguard_ip=$1

if [ ! -f host_vars/$hostname.yml ]; then
    public_key=`wg genkey | tr -d '\n' | tee $hostname.key | wg pubkey`
    private_key=`ansible-vault encrypt_string --vault-password-file ./.vault_password --encrypt-vault-id default --output - < $hostname.key`
    rm -f $hostname.key

    cat << EOF > host_vars/$hostname.yml
---
wireguard:
  ip: $wireguard_ip
  private_key: $private_key
  public_key: $public_key
  endpoint: $wireguard_endpoint_ip:51820
EOF
fi

if [ ! -f $hostname.yml ]; then
    cat << EOF > $hostname.yml
---
- import_playbook: common_roles.yml

- name: $hostname setup
  hosts: $hostname
  become: yes

  roles:
EOF
fi
