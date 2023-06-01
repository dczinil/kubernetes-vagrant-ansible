# -*- mode: ruby -*-
# vi: set ft=ruby :

#Master
##- etcd
##- kube-apiserver
##- kube-controller-manager
##- kube-scheduler
#Worker
##- kubelet kube-proxy
#
NUM_MASTER_ETCD = 2
NUM_MASTER_KACS = 2 
NUM_WORKER_NODE = 3 
NUM_LOADBALANCER = 1  

MASTER_IP_ETCD = 10
MASTER_IP_KACS = 20
NODE_IP_START = 30
LB_IP_START = 60
IP_NW = "192.168.56."

ssh_key = "../../.vagrant.d/insecure_private_key"

Vagrant.configure("2") do  |config|
  config.vm.box = "ubuntu/focal64"
  config.ssh.forward_agent = true
  config.ssh.private_key_path = ["~/.vagrant.d/insecure_private_key"]
  config.ssh.insert_key = false
  config.ssh.keys_only
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  (1..NUM_LOADBALANCER).each do |i|
    config.vm.define "K8SLB6#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "K8SLB6#{i}"
        vb.memory= 512
        vb.cpus= 1
      end
      node.vm.hostname = "K8SLB6#{i}"
      node.vm.network :private_network, ip: IP_NW + "#{LB_IP_START + i}", netmask: "255.255.255.0"
      #node.vm.network =   :forwarded_port, guest: 22, host: "#{226 + i}", host_ip: "#{LB_IP_START + i}"
    end
  end

  (1..NUM_MASTER_ETCD).each do |i|
    config.vm.define "K8SETCD1#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "K8SETCD1#{i}"
        vb.memory= 512
        vb.cpus= 1
      end
      node.vm.hostname = "K8SETCD#{MASTER_IP_ETCD + i}"
      node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_ETCD + i}", netmask: "255.255.255.0"
      #node.vm.network =   :forwarded_port, guest: 22, host: "#{221 + i}", host_ip: "0.0.0.0"
    end
  end

  (1..NUM_MASTER_KACS).each do |i|
    config.vm.define "K8SKACS2#{i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "K8SKACS2#{i}"
        vb.memory= 512
        vb.cpus=1
      end
      node.vm.hostname = "K8SKACS#{MASTER_IP_KACS + i}"
      node.vm.network :private_network, ip: IP_NW + "#{MASTER_IP_KACS + i}", netmask: "255.255.255.0"
      #node.vm.network =   :forwarded_port, guest: 22, host: "#{222 + i}", host_ip: "0.0.0.0"
    end
  end

  (1..NUM_WORKER_NODE).each do |i|
    config.vm.define "K8SWORKER#{NODE_IP_START + i}" do |node|
      node.vm.provider "virtualbox" do |vb|
        vb.name = "K8SWORKER#{NODE_IP_START + i}"
        vb.memory= 512
        vb.cpus=1
      end
      node.vm.hostname = "K8SWORKER#{NODE_IP_START + i}"
      node.vm.network :private_network, ip: IP_NW + "#{NODE_IP_START + i}", netmask: "255.255.255.0"
      #node.vm.network =   :forwarded_port, guest: 22, host: "#{22 + i}", host_ip: "0.0.0.0"
    end
  end

  config.vm.provision "file",before: :all, source: "../../.vagrant.d/insecure_private_key", destination: "/home/vagrant/.ssh/id_rsa.pub"
  config.vm.provision "ssh authorized_keys", after: :all, type: "shell", inline: <<-SHELL
    sed 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
    awk 'NR==43{print "UserKnownHostsFile=~/.ssh/known_hosts"}1' /etc/ssh/sshd_config
    sudo systemctl reload ssh
    touch /home/vagrant/.ssh/known_hosts
  SHELL

#    ssh -o UserKnownHostsFile=~/.ssh/known_hosts
#    config.vm.provision "ansible", after: :all do |ansible|
#    ssh-keygen -R $(ip -4 addr show enp0s8 | grep -oP "(?<=inet ).*(?=/)")
#    ansible.limit = "all"
#    ansible.playbook = "ansible/k8s-all.yaml"
#    ansible.inventory_path = "ansible/inventory.yaml"
#    ansible.groups = {
#      "all"   =>  ["K8SLB61", "K8SETCD11", "K8SETCD12", "K8SKACS21", "K8SKACS22", "K8SWORKER31", "K8SWORKER32", "K8SWORKER33"],
#      "etcd"    =>  ["K8SETCD11", "K8SETCD12"],
#      "kacs"    =>  ["K8SKACS21", "K8SKACS22"],
#      "worker"  =>  ["K8SWORKER31", "K8SWORKER32", "K8SWORKER33"],
#      "lb"      =>  ["K8SLB61"]
#    }
#    ansible.extra_vars = {
#      ca_k8s_expiry: "8760h",
#      ca_k8s_algo: "rsa",
#      ca_k8s_size: "2048",
#      ca_k8s_c: "MX",
#      ca_k8s_l: "SLP",
#      ca_k8s_o: "K8S",
#      ca_k8s_ou_ca: "CA",
#      ca_k8s_ou: "k8s",
#      ca_k8s_st: "Thyton",
#      ca_k8s_cn_admin: "admin",
#      ca_k8s_cn_kubernetes: "kubernetes",
#      csr_json: "script/cert/json/",
#      directory_cert: "/tmp/cert/",
#      SERVICE_NETWORK: '10.96.0.1',
#      POD_CIDR: '10.244.0.0/16',
#      API_SERVICE: '10.244.0.1',
#      CLUSTERDNS: '10.244.0.10',
#      NODE: "NUM_WORKER_NODE",
#      NUM_MASTER_ETCD: "NUM_MASTER_ETCD",
#      DISCOVERY_ETCD: "https://discovery.etcd.io/47a743f1cc0d4fa19f1afd45af62225e",
#      FETCH_COPY: "script/cert/pem",
#      DIRECTORY_PEM: "script/cert/pem/K8SLB61/tmp/cert/",
#      k8s_cert_hosts: "localhost,kubernetes,kubernetes.default,kubernetes.default.svc,kubernetes.default.svc.cluster,kubernetes.default.svc.cluster.local"
#    }
#    ansible.verbose= ""
#    ansible.raw_arguments  = [
#      "--private-key=../../.vagrant.d/insecure_private_key"
#    ]
#  end
end
