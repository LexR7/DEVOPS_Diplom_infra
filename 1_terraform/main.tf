terraform {
  required_version = ">= 1.0.0"
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.69.0"
    }
  }
}

provider "yandex" {
  service_account_key_file = file("/Users/r_alexey/EduProjects/terra-service.json")
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
}

module "vpc" {
  source = "./modules/yandex-vpc"

  name    = var.name
  subnets = var.subnets
}


module "vm-1" {
  source = "./modules/yandex-instance"

  vm_name       = "${var.name}-${var.vm_params[0].name}"
  vm_hostname   = var.vm_params[0].name
  vm_zone       = module.vpc.subnet_zones[0]
  family        = var.vm_params[0].family
  platform_id   = var.vm_params[0].platform_id
  nat           = var.vm_params[0].nat
  vpc_subnet_id = module.vpc.subnet_ids[0]
  users         = file("/Users/r_alexey/EduProjects/user_ansible.txt")
  resources     = var.vm_params[0].resources
}

module "vm-2" {
  source = "./modules/yandex-instance"

  vm_name       = "${var.name}-${var.vm_params[1].name}"
  vm_hostname   = var.vm_params[1].name
  vm_zone       = module.vpc.subnet_zones[0]
  family        = var.vm_params[1].family
  platform_id   = var.vm_params[1].platform_id
  nat           = var.vm_params[1].nat
  vpc_subnet_id = module.vpc.subnet_ids[0]
  users         = file("/Users/r_alexey/EduProjects/user_ansible.txt")
  resources     = var.vm_params[1].resources
}

module "vm-3" {
  source = "./modules/yandex-instance"

  vm_name       = "${var.name}-${var.vm_params[2].name}"
  vm_hostname   = var.vm_params[2].name
  vm_zone       = module.vpc.subnet_zones[0]
  family        = var.vm_params[2].family
  platform_id   = var.vm_params[2].platform_id
  nat           = var.vm_params[2].nat
  vpc_subnet_id = module.vpc.subnet_ids[0]
  users         = file("/Users/r_alexey/EduProjects/user_ansible.txt")
  resources     = var.vm_params[2].resources
}

#Создать инвентори файл для ансибл
resource "local_file" "inventory" {
    filename = "../2_ansible/inventory/inventory.ini"
    file_permission = "0644"
    content = <<-EOT
    [all]
     node1 ansible_host=${module.vm-1.external_ip_address}  ip=${module.vm-1.internal_ip_address} etcd_member_name=etcd1
     node2 ansible_host=${module.vm-2.external_ip_address}  ip=${module.vm-2.internal_ip_address} etcd_member_name=etcd1 node_labels="{'node-role.kubernetes.io/node':''}"
    [kube_control_plane]
     node1
    [etcd]
     node1
    [kube_node]
     node2
    [k8s_cluster:children]
     kube_control_plane
     kube_node
    [srv]
     node3 ansible_host=${module.vm-3.external_ip_address}  ip=${module.vm-3.internal_ip_address}
  EOT
}

module "nlb-1" {
  source              = "./modules/yandex-nlb"
  name                = var.name
  group_targets       = [{ subnet_id = module.vpc.subnet_ids[0], address = module.vm-2.internal_ip_address }]
  in_port             = var.nlb_params.in_port
  target_port         = var.nlb_params.targer_port
  healthcheck_params  = var.nlb_params.healthcheck_params
  health_http_options = var.nlb_params.health_http_options
  health_tcp_options  = var.nlb_params.health_tcp_options
}
