variable "name" {
  description = "Наименование"
  type        = string
}

variable "group_targets" {
  description = "Параметры создаваемой группы (subnet_id,address)"
  type = list(object({
    subnet_id = string
    address   = string
  }))
}

variable "in_port" {
  description = "Входящий порт"
  type        = number
  default     = 80
}

variable "target_port" {
  description = "Порт назначения"
  type        = number
  default     = 80
}

variable "ip_version" {
  description = "Версия IP протокола"
  type        = string
  default     = "ipv4"
}

variable "healthcheck_params" {
  description = "Параметры health-проверки"
  type = object({
    name                = string
    interval            = number
    timeout             = number
    unhealthy_threshold = number
    healthy_threshold   = number
  })
  default = ({
    name                = "http"
    interval            = 2
    timeout             = 1
    unhealthy_threshold = 2
    healthy_threshold   = 2
  })
}

variable "health_http_options" {
  description = "Параметры проверки HTTP"
  type = list(object({
    port = number
    path = string
  }))
}

variable "health_tcp_options" {
  description = "Параметры проверки TCP (должен быть задан либо HTTP либо TCP)"
  type = list(object({
    port = number
  }))
}
