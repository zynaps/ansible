#!/bin/sh

host=$2
ip=$1
endpoint=$3
port=51820

if [ ! -f host_vars/$host.yml ]; then
    public_key=`wg genkey | tee $host.key | wg pubkey`
    private_key=`ansible-vault encrypt_string --vault-password-file ./.vault_password --encrypt-vault-id default --output - < $host.key`
    rm -f $host.key

    cat << EOF > host_vars/$host.yml
---
wireguard:
  ip: $ip
  private_key: $private_key
  public_key: $public_key
  endpoint: $endpoint:$port
EOF
fi

if [ ! -f $host.yml ]; then
    cat << EOF > $host.yml
---
- import_playbook: common_roles.yml

- name: $host setup
  hosts: $host
  become: yes

EOF
fi
