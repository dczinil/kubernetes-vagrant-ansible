# -*- mode: ruby -*-
# vi: set ft=ruby :

#Master
##- etcd
##- kube-apiserver
##- kube-controller-manager
##- kube-scheduler
#Worker
##- kubelet kube-proxy

#NUM_MASTER_NODE = 
NUM_MASTER_ETC = 1 #In Process
NUM_MASTER_KAPI = 1 #In Process
NUM_MASTER_KCM = 1 #In Process
NUM_MASTER_KSC = 1 #In Process
NUM_WORKER_NODE = 
NUM_LOADBALANCER = 1  

IP_NW = "192.168.56."
MASTER_IP_START = 10
NODE_IP_START = 20
LB_IP_START = 30

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"

  (1..NUM_MASTER_ETC).each do |i|
    config.vm.define "k8s-ha-etcd-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-etc-#{i}"
        vb.memory= 1024
        vb.cpus=1
      end
    end
  end

  (1..NUM_MASTER_KAPI).each do |i|
    config.vm.define "k8s-ha-kapi-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-kapi-#{i}"
        vb.memory= 1024
        vb.cpus=1
      end
    end
  end

  (1..NUM_MASTER_KCM).each do |i|
    config.vm.define "k8s-ha-kcm-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-kcm-#{i}"
        vb.memory= 1024
        vb.cpus=1
      end
    end
  end


  (1..NUM_MASTER_KSC).each do |i|
    config.vm.define "k8s-ha-ksc-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-ksc-#{i}"
        vb.memory= 1024
        vb.cpus=1
      end
    end
  end

  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "k8s-ha-worker-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-worker-#{i}"
        vb.memory= 1024
        vb.cpus=1
      end
    end
  end

  (1..NUM_LOADBALANCER).each do |i|
    config.vm.define "k8s-ha-lb-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-lb-#{i}"
        vb.memory= 1024
        vb.cpus=1
      end
    end
  end

end
