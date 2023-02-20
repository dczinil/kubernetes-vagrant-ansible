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
NUM_MASTER_ETCD = 2 #In Process
NUM_MASTER_KAPI = 1 #In Process
NUM_MASTER_KCM = 1 #In Process
NUM_MASTER_KSC = 1 #In Process
NUM_WORKER_NODE = 1
NUM_LOADBALANCER = 1  

MASTER_IP_ETCD = 10
MASTER_IP_KAPI = 20
MASTER_IP_KCM = 30
MASTER_IP_KSC = 40
NODE_IP_START = 50
LB_IP_START = 60
IP_NW = "192.168.56."


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.ssh.insert_key = false

  (0..NUM_MASTER_ETCD).each do |i|
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.vm.define "K8S-ETCD-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "K8S-ETCD-#{i}"
        vb.memory= 512
        vb.cpus= 1
      end
      node.vm.hostname = "K8S-ETCD-#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_ETCD + i}" 

    end
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/k8s-etcd.yml"
      ansible.extra_vars = {
      }
      ansible.verbose = "v"
    end
  end

#   (0..NUM_MASTER_KAPI).each do |i|
#     config.vm.define "K8S-KAPI-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "K8S-KAPI-#{i}"
#         vb.memory= 512
#         vb.cpus=1
#       end
#       node.vm.hostname = "K8S-KAPI-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_KAPI + i}", netmask: "255.255.255.0"
#     end
#   end
# 
#   (0..NUM_MASTER_KCM).each do |i|
#     config.vm.define "K8S-KCM-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "K8S-KCM-#{i}"
#         vb.memory= 512
#         vb.cpus=1
#       end
#       node.vm.hostname = "K8S-KCM-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_KCM + i}", netmask: "255.255.255.0"
#     end
#   end
# 
# 
#   (0..NUM_MASTER_KSC).each do |i|
#     config.vm.define "K8S-KSC-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "K8S-KSC-#{i}"
#         vb.memory= 512
#         vb.cpus=1
#       end
#       node.vm.hostname = "K8S-KSC-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_KSC + i}", netmask: "255.255.255.0"
#     end
#   end
# 
#   (0..NUM_WORKER_NODE).each do |i|
#     config.vm.define "K8S-WORKER-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "K8S-WORKER-#{i}"
#         vb.memory= 512
#         vb.cpus=1
#       end
#       node.vm.hostname = "K8S-WORKER-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}", netmask: "255.255.255.0"
#     end
#   end
# 
#    (0..NUM_LOADBALANCER).each do |i|
#      config.vm.define "K8S-LB-#{i}" do |node|
#        node.vm.provider "virtualbox" do |vb|
#          vb.name = "K8S-LB-#{i}"
#          vb.memory= 512
#          vb.cpus=1
#        end
#        node.vm.hostname = "K8S-LB-#{i}"
#        node.vm.network :private_network, ip: IP_NW + "#{LB_IP_START + i}", netmask: "255.255.255.0"
#      end
#    end
end
