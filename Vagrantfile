# -*- mode: ruby -*-
# vi: set ft=ruby :

#Master
##- etcd
##- kube-apiserver
##- kube-controller-manager
##- kube-scheduler
#Worker
##- kubelet kube-proxy

NUM_MASTER_ETCD = 1 #In Process
NUM_MASTER_KACS = 2
NUM_WORKER_NODE = 1
NUM_LOADBALANCER = 1  

MASTER_IP_ETCD = 10
MASTER_IP_KACS = 20
NODE_IP_START = 30
LB_IP_START = 60
IP_NW = "192.168.56."


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.ssh.insert_key = false
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

#  (1..NUM_MASTER_ETCD).each do |i|
#    config.vm.define "K8SETCD1{i}" do |node|
#      node.vm.provider "virtualbox" do |vb|
#        vb.name = "K8SETCD1{i}"
#        vb.memory= 512
#        vb.cpus= 1
#      end
#      node.vm.hostname = "K8SETCD{MASTER_IP_ETCD + i}"
#      node.vm.network :private_network, ip: IP_NW + "{MASTER_IP_ETCD + i}"
#
#    end
#    config.vm.provision "ansible" do |ansible|
#      ansible.playbook = "ansible/k8s-etcd.yml"
#      ansible.extra_vars = {
#      }
#      ansible.verbose = "v"
#    end
#  end
#
#  (1..NUM_MASTER_KACS).each do |i|
#    config.vm.define "K8SKACS#{i}" do |node|
#      node.vm.provider "virtualbox" do |vb|
#        vb.name = "K8SKAPI2#{i}"
#        vb.memory= 512
#        vb.cpus=1
#      end
#      node.vm.hostname = "K8SKACS#{MASTER_IP_KACS + i}"
#      node.vm.network :private_network, ip: IP_NW + "#{NUM_MASTER_KACS + i}", netmask: "255.255.255.0"
#    end
#    config.vm.provision "ansible" do |ansible|
#      ansible.playbook= "ansible/k8s-kacs.yml"
#      ansible.extra_vars = {
#      }
#      ansible.verbose= "v"
#    end
#  end
# 
  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "K8SWORKER#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "K8SWORKER#{NODE_IP_START + i}"
        vb.memory= 512
        vb.cpus=1
      end
      node.vm.hostname = "K8SWORKER#{NODE_IP_START + i}"
      node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}", netmask: "255.255.255.0"
    end
    config.vm.provision "ansible" do |ansible|
      ansible.playbook= "ansible/k8s-worker.yml"
      ansible.extra_vars = {
      }
      ansible.verbose= "v"
    end
  end
# 
#    (1..NUM_LOADBALANCER).each do |i|
#      config.vm.define "K8SLB6#{i}" do |node|
#        node.vm.provider "virtualbox" do |vb|
#          vb.name = "K8SLB6#{i}"
#          vb.memory= 512
#          vb.cpus=1
#        end
#        node.vm.hostname = "K8SLB6#{i}"
#        node.vm.network :private_network, ip: IP_NW + "#{LB_IP_START + i}", netmask: "255.255.255.0"
#      end
#    end
end
