resource "yandex_lb_target_group" "this" {
  name = "${var.name}-target-group"

  dynamic "target" {
    for_each = var.group_targets
    content {
      subnet_id = target.value.subnet_id
      address   = target.value.address
    }
  }
}

resource "yandex_lb_network_load_balancer" "this" {
  name = "${var.name}-load-balancer"

  listener {
    name        = "${var.name}-listener"
    port        = var.in_port
    target_port = var.target_port
    external_address_spec {
      ip_version = var.ip_version
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.this.id

    healthcheck {
      name                = var.healthcheck_params.name
      interval            = var.healthcheck_params.interval
      timeout             = var.healthcheck_params.timeout
      unhealthy_threshold = var.healthcheck_params.unhealthy_threshold
      healthy_threshold   = var.healthcheck_params.healthy_threshold
      dynamic "http_options" {
        for_each = var.health_http_options
        content {
          port = http_options.value.port
          path = http_options.value.path
        }
      }
      dynamic "tcp_options" {
        for_each = var.health_tcp_options
        content {
          port = tcp_options.value.port
        }
      }
    }
  }
}
