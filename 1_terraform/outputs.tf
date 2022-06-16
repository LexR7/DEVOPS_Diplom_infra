output "internal_ip_address_vm_1" {
  description = "Назначенный внутренний IP-адрес"
  value       = module.vm-1.internal_ip_address
}

output "external_ip_address_vm_1" {
  description = "Назначенный внешний IP-адрес"
  value       = module.vm-1.external_ip_address
}

output "internal_ip_address_vm_2" {
  description = "Назначенный внутренний IP-адрес"
  value       = module.vm-2.internal_ip_address
}

output "external_ip_address_vm_2" {
  description = "Назначенный внешний IP-адрес"
  value       = module.vm-2.external_ip_address
}

output "internal_ip_address_vm_3" {
  description = "Назначенный внутренний IP-адрес"
  value       = module.vm-3.internal_ip_address
}

output "external_ip_address_vm_3" {
  description = "Назначенный внешний IP-адрес"
  value       = module.vm-3.external_ip_address
}

output "loadbalancer_ip_address" {
  description = "Назначенный внешний IP-адрес балансировщика"
  value       = module.nlb-1.nlb_external_ip
}
