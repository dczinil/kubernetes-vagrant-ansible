# -*- mode: ruby -*-
# vi: set ft=ruby :

#Master
##- etcd
##- kube-apiserver
##- kube-controller-manager
##- kube-scheduler
#Worker
##- kubelet kube-proxy

NUM_MASTER_ETC = 1 #In Process
NUM_MASTER_KAPI = #In Process
NUM_MASTER_KCM = #In Process
NUM_MASTER_KSC = #In Process
NUM_MASTER_NODE = 
NUM_WORKER_NODE = 

IP_NW = "192.168.56."
MASTER_IP_START = 10
NODE_IP_START = 20
LB_IP_START = 30

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  (1..NUM_MASTER_ETC).each do |i|
    config.vm.define "master-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-etc-#{i}"
        vb.memory= 1024
        vb.cpus=1
      end
    end
  end
end
