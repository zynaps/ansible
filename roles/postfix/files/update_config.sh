#!/bin/sh

postconf myhostname=escape.zynaps.ru
postconf mynetworks="127.0.0.1/32 10.7.0.0/24"

sed -i -r -e '/^#root/s/^#//' -e '/^root/s/you$/zynaps@gmail.com/' /etc/postfix/aliases
postalias /etc/postfix/aliases

cat << EOF > /etc/postfix/virtual
/^(zynaps(\+\w+)?|igor|(a|b)-\w+|(h|p)ostmaster)@zynaps.ru$/ zynaps@gmail.com
EOF
postmap /etc/postfix/virtual
postconf virtual_alias_maps=regexp:/etc/postfix/virtual
postconf virtual_alias_domains=zynaps.ru

postconf message_size_limit=50240000

echo "/^\d+@qq\.com$/ DISCARD" > /etc/postfix/sender_access
postmap /etc/postfix/sender_access
postconf smtpd_sender_restrictions='check_sender_access regexp:/etc/postfix/sender_access'

postfix check || exit 1
