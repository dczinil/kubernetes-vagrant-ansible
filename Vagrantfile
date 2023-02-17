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

IP_NW = "192.168.56."
MASTER_IP_ETCD = 10
MASTER_IP_KAPI = 20
MASTER_IP_KCM = 30
MASTER_IP_KSC = 40
NODE_IP_START = 50
LB_IP_START = 60

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/focal64"
  config.ssh.insert_key = false

  (1..NUM_MASTER_ETCD).each do |i|
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    config.vm.define "k8s-ha-etcd-#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "k8s-ha-etcd-#{i}"
        vb.memory= 512
        vb.cpus= 1
      end
      node.vm.hostname = "k8s-ha-etcd-#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_ETCD + i}", netmask: "255.255.255.0"

    end
    config.vm.provision "ansible" do |ansible|
      ansible.playbook = "ansible/k8s-etcd.yml"
      ansible.extra_vars = {
        node_hosts: "k8s-ha-etcd-#{i + 9}",
        node_ip: "192.168.56.#{i + 9}",
      }
    end
  end

#   (1..NUM_MASTER_KAPI).each do |i|
#     config.vm.define "k8s-ha-kapi-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "k8s-ha-kapi-#{i}"
#         vb.memory= 1024
#         vb.cpus=1
#       end
#       node.vm.hostname = "k8s-ha-kapi-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_KAPI + i}", netmask: "255.255.255.0"
#     end
#   end
# 
#   (1..NUM_MASTER_KCM).each do |i|
#     config.vm.define "k8s-ha-kcm-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "k8s-ha-kcm-#{i}"
#         vb.memory= 1024
#         vb.cpus=1
#       end
#       node.vm.hostname = "k8s-ha-kcm-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_KCM + i}", netmask: "255.255.255.0"
#     end
#   end
# 
# 
#   (1..NUM_MASTER_KSC).each do |i|
#     config.vm.define "k8s-ha-ksc-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "k8s-ha-ksc-#{i}"
#         vb.memory= 1024
#         vb.cpus=1
#       end
#       node.vm.hostname = "k8s-ha-KSC-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_KSC + i}", netmask: "255.255.255.0"
#     end
#   end
# 
#   (1..NUM_WORKER_NODE).each do |i|
#     config.vm.define "k8s-ha-worker-#{i}" do |node|
#       node.vm.provider "virtualbox" do |vb|
#         vb.name = "k8s-ha-worker-#{i}"
#         vb.memory= 512
#         vb.cpus=1
#       end
#       node.vm.hostname = "k8s-ha-worker-#{i}"
#       node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}", netmask: "255.255.255.0"
#     end
#   end
# 
#    (1..NUM_LOADBALANCER).each do |i|
#      config.vm.define "k8s-ha-lb-#{i}" do |node|
#        node.vm.provider "virtualbox" do |vb|
#          vb.name = "k8s-ha-lb-#{i}"
#          vb.memory= 512
#          vb.cpus=1
#        end
#        node.vm.hostname = "k8s-ha-lb-#{i}"
#        node.vm.network :private_network, ip: IP_NW + "#{LB_IP_START + i}", netmask: "255.255.255.0"
#      end
#    end

end
