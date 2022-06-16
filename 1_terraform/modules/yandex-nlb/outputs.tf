output "target_group_id" {
  description = "Идентификатор группы"
  value       = yandex_lb_target_group.this.id
}

output "nlb_external_ip" {
  description = "Назначенный внешний IP-адрес балансировщика"
  value       = yandex_lb_network_load_balancer.this.listener.*.external_address_spec[0].*.address[0]
}
