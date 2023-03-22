#!/bin/bash

source hosts.sh

#

cat <<EOF | tee etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos

[Service]
Type=notify
ExecStart=/usr/local/bin/etcd \\
  --name ETCD_NAME \\
  --cert-file=/etc/etcd/kubernetes.pem \\
  --key-file=/etc/etcd/kubernetes-key.pem \\
  --peer-cert-file=/etc/etcd/kubernetes.pem \\
  --peer-key-file=/etc/etcd/kubernetes-key.pem \\
  --trusted-ca-file=/etc/etcd/ca.pem \\
  --peer-trusted-ca-file=/etc/etcd/ca.pem \\
  --peer-client-cert-auth \\
  --client-cert-auth \\
  --initial-advertise-peer-urls https://${K8SETCD11}:2380 \\
  --listen-peer-urls https://${K8SETCD11}:2380 \\
  --listen-client-urls https://${K8SETCD11}:2379,https://127.0.0.1:2379 \\
  --advertise-client-urls https://${K8SETCD11}:2379 \\
  --initial-cluster-token ETCD-kyber \\
  --initial-cluster ${CLUSTER_ETCD} \\
  --initial-cluster-state new \\
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

###############################################################################

mv *.service services 
