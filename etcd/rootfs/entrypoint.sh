#!/bin/bash
mkdir /root/.ssh
mkdir -p /var/run/sshd
chmod 600 /root/.ssh
chmod 600 /etc/ssh/*
touch /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys
echo $SSH_KEY > /root/.ssh/authorized_keys
service ssh start 

if [ $RESTIC_REPOSITORY ]; then
    restic restore latest --target /
    rm -rf /bitnami/etcd/
    etcdctl snapshot restore /tmp/vdc_etcd.db --data-dir=/bitnami/etcd/data --skip-hash-check=true
fi
