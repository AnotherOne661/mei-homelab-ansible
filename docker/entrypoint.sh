#!/bin/bash
set -e

mkdir -p /run/sshd

useradd -m -s /bin/bash ansible 2>/dev/null || true
echo 'ansible:ansible' | chpasswd

echo 'ansible ALL=(ALL) ALL' > /etc/sudoers.d/ansible
chmod 440 /etc/sudoers.d/ansible

mkdir -p /home/ansible/.ssh

cp /ssh/id_ed25519.pub /home/ansible/.ssh/authorized_keys

chown -R ansible:ansible /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/authorized_keys

systemctl enable ssh

exec /sbin/init
