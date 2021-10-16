#!/bin/sh

host=$2
domain=zynaps.ru
ip=$1
endpoint=$3
port=51820

if [ ! -f host_vars/$host.$domain.yml ]; then
    public_key=`wg genkey | tee $host.key | wg pubkey`
    private_key=`ansible-vault encrypt_string --vault-password-file ./.vault_password --encrypt-vault-id default --output - < $host.key`
    rm -f $host.key

    cat << EOF > host_vars/$host.$domain.yml
---
wireguard:
  ip: $ip
  private_key: $private_key
  public_key: $public_key
  endpoint: $endpoint:$port
EOF
fi

if [ ! -f $host.$domain.yml ]; then
    cat << EOF > $host.$domain.yml
---
- import_playbook: common_roles.yml

- name: $host setup
  hosts: $host.$domain
  become: yes

EOF
fi
