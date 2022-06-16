# yandex-nlb

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | ~> 0.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | 0.69.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_lb_network_load_balancer.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer) | resource |
| [yandex_lb_target_group.this](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_target_group) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_group_targets"></a> [group\_targets](#input\_group\_targets) | Параметры создаваемой группы (subnet\_id,address) | <pre>list(object({<br>    subnet_id = string<br>    address   = string<br>  }))</pre> | n/a | yes |
| <a name="input_health_http_options"></a> [health\_http\_options](#input\_health\_http\_options) | Параметры проверки HTTP | <pre>list(object({<br>    port = number<br>    path = string<br>  }))</pre> | n/a | yes |
| <a name="input_health_tcp_options"></a> [health\_tcp\_options](#input\_health\_tcp\_options) | Параметры проверки TCP (должен быть задан либо HTTP либо TCP) | <pre>list(object({<br>    port = number<br>  }))</pre> | n/a | yes |
| <a name="input_healthcheck_params"></a> [healthcheck\_params](#input\_healthcheck\_params) | Параметры health-проверки | <pre>object({<br>    name                = string<br>    interval            = number<br>    timeout             = number<br>    unhealthy_threshold = number<br>    healthy_threshold   = number<br>  })</pre> | <pre>{<br>  "healthy_threshold": 2,<br>  "interval": 2,<br>  "name": "http",<br>  "timeout": 1,<br>  "unhealthy_threshold": 2<br>}</pre> | no |
| <a name="input_in_port"></a> [in\_port](#input\_in\_port) | Входящий порт | `number` | `80` | no |
| <a name="input_ip_version"></a> [ip\_version](#input\_ip\_version) | Версия IP протокола | `string` | `"ipv4"` | no |
| <a name="input_name"></a> [name](#input\_name) | Наименование | `string` | n/a | yes |
| <a name="input_target_port"></a> [target\_port](#input\_target\_port) | Порт назначения | `number` | `80` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nlb_external_ip"></a> [nlb\_external\_ip](#output\_nlb\_external\_ip) | Назначенный внешний IP-адрес балансировщика |
| <a name="output_target_group_id"></a> [target\_group\_id](#output\_target\_group\_id) | Идентификатор группы |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
