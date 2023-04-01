#!/bin/bash
#
source ./hosts
#--Create certificate--#
cat > ca-config.json <<EOF
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
EOF
cat > ca-csr.json <<EOF
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "K8S",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert -initca ca-csr.json | cfssljson -bare ca
######################################################################################
######################################################################################
######################################################################################
cat > admin-csr.json <<EOF
{
  "CN": "admin",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "system:masters",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  admin-csr.json | cfssljson -bare admin
######################################################################################
######################################################################################
######################################################################################
for((i=30;i<60;i++));
do
cat > K8SWORKER${i}-csr.json <<EOF
{
  "CN": "system:node:K8SWORKER${i}",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "system:nodes",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=K8SWORKER${i},${K8SLB61},${RANGO}${i} \
  -profile=kubernetes \
  K8SWORKER${i}-csr.json | cfssljson -bare K8SWORKER$i
done
######################################################################################
######################################################################################
######################################################################################
cat > kube-controller-manager-csr.json <<EOF
{
  "CN": "system:kube-controller-manager",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "system:kube-controller-manager",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-controller-manager-csr.json | cfssljson -bare kube-controller-manager
######################################################################################
######################################################################################
######################################################################################
cat > kube-proxy-csr.json <<EOF
{
  "CN": "system:kube-proxy",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "system:node-proxier",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-proxy-csr.json | cfssljson -bare kube-proxy
######################################################################################
######################################################################################
######################################################################################
cat > kube-scheduler-csr.json <<EOF
{
  "CN": "system:kube-scheduler",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "system:kube-scheduler",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  kube-scheduler-csr.json | cfssljson -bare kube-scheduler
######################################################################################
######################################################################################
######################################################################################
KUBERNETES_HOSTNAMES=kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.kyber,kubernetes.svc.kyber.local
cat > kubernetes-csr.json <<EOF
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "K8S",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname=10.96.0.1,${K8SKACS21},${K8SKACS22},${K8SKACS23},${K8SETCD11},${K8SETCD12},${K8SETCD13},$K8SLB61,127.0.0.1,$KUBERNETES_HOSTNAMES \
  -profile=kubernetes \
  kubernetes-csr.json | cfssljson -bare kubernetes
######################################################################################
######################################################################################
######################################################################################
cat > service-account-csr.json <<EOF
{
  "CN": "service-accounts",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "MX",
      "L": "SLP",
      "O": "K8S",
      "OU": "K8S",
      "ST": "Thyton"
    }
  ]
}
EOF
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -profile=kubernetes \
  service-account-csr.json | cfssljson -bare service-account

#####################################################################################
#####################################################################################
#####################################################################################
{
for((i=30;i<60;i++));
do
kubectl config set-cluster k8s --certificate-authority=ca.pem --embed-certs=true --server=https:${K8SLB61} --kubeconfig=K8SWORKER${i}.kubeconfig
kubectl config set-credentials system:node:K8SWORKER${i} --client-certificate=K8SWORKER${i}.pem --client-key=K8SWORKER${i}-key.pem --embed-certs=true --kubeconfig=K8SWORKER${i}.kubeconfig
kubectl config set-context default --cluster=k8s --user=system:node:K8SWORKER${i} --kubeconfig=K8SWORKER${i}.kubeconfig
kubectl config use-context default --kubeconfig=K8SWORKER${i}.kubeconfig
done
}
#####################################################################################
#####################################################################################
#####################################################################################
{
kubectl config set-cluster k8s --certificate-authority=ca.pem --embed-certs=true --server=https://${K8SLB61}:6443 --kubeconfig=kube-proxy.kubeconfig
kubectl config set-credentials system:kube-proxy --client-certificate=kube-proxy.pem --client-key=kube-proxy-key.pem --embed-certs=true --kubeconfig=kube-proxy.kubeconfig
kubectl config set-context default --cluster=k8s --user=system:kube-proxy --kubeconfig=kube-proxy.kubeconfig
kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
}
#####################################################################################
#####################################################################################
#####################################################################################
{
kubectl config set-cluster k8s --certificate-authority=ca.pem --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=kube-controller-manager.kubeconfig
kubectl config set-credentials system:kube-controller-manager --client-certificate=kube-controller-manager.pem --client-key=kube-controller-manager-key.pem --embed-certs=true --kubeconfig=kube-controller-manager.kubeconfig
kubectl config set-context default --cluster=k8s --user=system:kube-controller-manager --kubeconfig=kube-controller-manager.kubeconfig
kubectl config use-context default --kubeconfig=kube-controller-manager.kubeconfig
}
#####################################################################################
#####################################################################################
#####################################################################################
{
kubectl config set-cluster k8s --certificate-authority=ca.pem --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=kube-scheduler.kubeconfig
kubectl config set-credentials system:kube-scheduler --client-certificate=kube-scheduler.pem --client-key=kube-scheduler-key.pem --embed-certs=true --kubeconfig=kube-scheduler.kubeconfig
kubectl config set-context default --cluster=k8s --user=system:kube-scheduler --kubeconfig=kube-scheduler.kubeconfig
kubectl config use-context default --kubeconfig=kube-scheduler.kubeconfig
}
#####################################################################################
#####################################################################################
#####################################################################################
{
kubectl config set-cluster k8s --certificate-authority=ca.pem --embed-certs=true --server=https://127.0.0.1:6443 --kubeconfig=admin.kubeconfig
kubectl config set-credentials admin --client-certificate=admin.pem --client-key=admin-key.pem --embed-certs=true --kubeconfig=admin.kubeconfig
kubectl config set-context default --cluster=k8s --user=admin --kubeconfig=admin.kubeconfig
kubectl config use-context default --kubeconfig=admin.kubeconfig
}
#####################################################################################
#####################################################################################
#####################################################################################
#
#
#
#
#
#
mv *.pem *.json *.csr *.kubeconfig cert/
