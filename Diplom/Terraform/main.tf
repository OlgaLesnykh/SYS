terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  token = var.yandex_cloud_token
  cloud_id = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
  }

# Веб сервер 1

resource "yandex_compute_instance" "web-server-1" {
  name = "web-server-1"
  hostname = "web-server-1"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = false
    ip_address = "192.168.10.5"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id,
                          yandex_vpc_security_group.external-balancer.id,
                          yandex_vpc_security_group.external-zabbix-server.id]
  }
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
scheduling_policy {
    preemptible = false
  }
    zone = "ru-central1-a"
}
# Веб сервер 2

resource "yandex_compute_instance" "web-server-2" {
  name = "web-server-2"
  hostname = "web-server-2"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-2.id
    nat       = false
    ip_address = "192.168.20.5"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id,
                          yandex_vpc_security_group.external-balancer.id,
                          yandex_vpc_security_group.external-zabbix-server.id]
  }
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
scheduling_policy {
    preemptible = false
  }
  zone = "ru-central1-b"
}
# Бастион хост

resource "yandex_compute_instance" "bastion-host" {
  name = "bastion-host"
  hostname = "bastion"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.bastion-external-segment.id
    ip_address = "172.16.17.7"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.secure-bastion-sg.id,
                          yandex_vpc_security_group.internal-bastion-sg.id,
                          yandex_vpc_security_group.external-zabbix-server.id]
  }

  metadata = {
    user-data = "${file("./bastion-meta.yml")}"
  }
scheduling_policy {
    preemptible = false
  }
  zone = "ru-central1-b"
}

# Zabbix-сервер

resource "yandex_compute_instance" "zabbix-server" {
  name = "zabbix-server"
  hostname = "zabbix-server"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.bastion-external-segment.id
    ip_address = "172.16.17.9"
    nat       = true
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id,
                          yandex_vpc_security_group.secure-bastion-sg.id,
                          yandex_vpc_security_group.internal-zabbix-server.id,
                          yandex_vpc_security_group.external-zabbix-server.id]
  }
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
scheduling_policy {
    preemptible = false
  }
    zone = "ru-central1-b"
}

# Elasticsearch-сервер

resource "yandex_compute_instance" "elasticsearch" {
  name = "elasticsearch"
  hostname = "elasticsearch-server"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.bastion-internal-segment.id
    nat       = false
    ip_address = "172.16.16.20"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id,
                          yandex_vpc_security_group.elasticsearch.id,
                          yandex_vpc_security_group.external-zabbix-server.id]
  }
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
scheduling_policy {
    preemptible = false
  }
    zone = "ru-central1-b"
}

# kibana-сервер

resource "yandex_compute_instance" "kibana" {
name = "kibana"
  hostname = "kibana-server"
  allow_stopping_for_update = true
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.bastion-external-segment.id
    nat       = true
    ip_address = "172.16.17.8"
    security_group_ids = [yandex_vpc_security_group.internal-bastion-sg.id,
                          yandex_vpc_security_group.secure-bastion-sg.id,
                          yandex_vpc_security_group.elasticsearch.id,
                          yandex_vpc_security_group.external-zabbix-server.id,
                          yandex_vpc_security_group.kibana.id,]
  }
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
scheduling_policy {
    preemptible = false
  }
    zone = "ru-central1-b"
}

# Сеть VPC

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

# Подсеть в зоне а

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# Подсеть в зоне b

resource "yandex_vpc_subnet" "subnet-2" {
  name           = "subnet2"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}
# Внешняя подсеть для бастиона

resource "yandex_vpc_subnet" "bastion-external-segment" {
  name           = "bastion-external"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["172.16.17.0/28"]
}

# Внутренняя подсеть для бастиона

resource "yandex_vpc_subnet" "bastion-internal-segment" {
  name           = "bastion-internal"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["172.16.16.0/24"]
  route_table_id = yandex_vpc_route_table.rt.id
}

# NAT-шлюз

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "test-gateway"
  shared_egress_gateway {}
}

# Таблица маршрутизации

resource "yandex_vpc_route_table" "rt" {
  name       = "route-table"
  network_id = yandex_vpc_network.network-1.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

# Target group

resource "yandex_alb_target_group" "target-group" {
  name           = "target-group"
  target {
    subnet_id    = yandex_vpc_subnet.subnet-1.id
    ip_address   = yandex_compute_instance.web-server-1.network_interface.0.ip_address
  }
  target {
    subnet_id    = yandex_vpc_subnet.subnet-2.id
    ip_address   = yandex_compute_instance.web-server-2.network_interface.0.ip_address
  }
}

# Backend group

resource "yandex_alb_backend_group" "backend-group" {
  name                     = "backend-group"

http_backend {
    name                   = "http-backend"
    weight                 = 1
    port                   = 80
    target_group_ids       = [yandex_alb_target_group.target-group.id]
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

# HTTP-роутер

resource "yandex_alb_http_router" "tf-router" {
  name          = "tf-router"
}

resource "yandex_alb_virtual_host" "my-virtual-host" {
  name                    = "my-virtual-host"
  http_router_id          = yandex_alb_http_router.tf-router.id
  route {
    name                  = "http-rout"
    http_route {
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.backend-group.id
        timeout           = "60s"
      }
    }
  }
}

# L7 балансировщик

resource "yandex_alb_load_balancer" "ip-balancer" {
  name        = "ip-balancer"
  network_id  = yandex_vpc_network.network-1.id
  security_group_ids = [yandex_vpc_security_group.internal-balancer.id]

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-1.id
    }
    location {
      zone_id   = "ru-central1-b"
      subnet_id = yandex_vpc_subnet.subnet-2.id
    }
  }

  listener {
    name = "ip-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
	  ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.tf-router.id
      }
    }
  }
}
# Группа безопасности для bastion-internal-segment

resource "yandex_vpc_security_group" "internal-bastion-sg" {
  name        = "internal-bastion-sg"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["172.16.17.7/32"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
  egress {
    protocol       = "TCP"
    v4_cidr_blocks = ["172.16.17.7/32"]
    port           = 22
  }
}
# Группа безопасности для bastion-external-segment
resource "yandex_vpc_security_group" "secure-bastion-sg" {
  name        = "secure-bastion-sg"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 22
  }
  ingress {
    protocol       = "TCP"
    security_group_id = yandex_vpc_security_group.internal-bastion-sg.id
    port           = 22
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
  egress {
    protocol       = "TCP"
    port           = 22
    security_group_id = yandex_vpc_security_group.internal-bastion-sg.id
  }
}
# Группа безопасности для трафика на балансировщике

resource "yandex_vpc_security_group" "internal-balancer" {
  name        = "internal-balancer"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    predefined_target = "loadbalancer_healthchecks"
    port           = 30080
  }
  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

# Группа безопасности для трафика от балансировщика на web-серверы

resource "yandex_vpc_security_group" "external-balancer" {
  name        = "external-balancer"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    security_group_id = yandex_vpc_security_group.internal-balancer.id
    port           = 80
  }
}

# Группа безопасности для трафика на Zabbix-сервере

resource "yandex_vpc_security_group" "internal-zabbix-server" {
  name        = "internal-zabbix-server"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
  ingress {
    protocol       = "TCP"
    security_group_id = yandex_vpc_security_group.external-zabbix-server.id
    from_port           = 10050
    to_port        = 10051
  }
  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
  egress {
    protocol       = "TCP"
    from_port           = 0
    to_port        = 65535
	security_group_id = yandex_vpc_security_group.internal-bastion-sg.id
  }
}

# Группа безопасности для трафика от Zabbix-сервера  на Zabbix-агенты

resource "yandex_vpc_security_group" "external-zabbix-server" {
  name        = "external-zabbix-server"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol       = "TCP"
    v4_cidr_blocks = ["172.16.17.9/32"]
    from_port      = 10050
    to_port        = 10051
  }
}

# Группа безопасности для трафика на Elasticsearch-сервер

resource "yandex_vpc_security_group" "elasticsearch" {
  name        = "elasticsearch"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol          = "TCP"
    security_group_id = yandex_vpc_security_group.internal-bastion-sg.id
    port = 9200
  }

  ingress {
    protocol          = "TCP"
    security_group_id = yandex_vpc_security_group.internal-bastion-sg.id
    port = 9300
  }

}

# Группа безопасности для трафика на Kibana-сервер

resource "yandex_vpc_security_group" "kibana" {
  name        = "kibana"
  network_id  = "${yandex_vpc_network.network-1.id}"

  ingress {
    protocol          = "TCP"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port = 5601
  }
}

# Расписание снапшотов

resource "yandex_compute_snapshot_schedule" "snapshot" {
  name           = "snapshot"

  schedule_policy {
        expression = "0 0 * * *"
  }

  snapshot_count = 7
  retention_period = "168h"
  snapshot_spec {
          description = "snapshot-everyday"
  }

  disk_ids = ["${yandex_compute_instance.web-server-1.boot_disk.0.disk_id}",
              "${yandex_compute_instance.web-server-2.boot_disk.0.disk_id}",
              "${yandex_compute_instance.bastion-host.boot_disk.0.disk_id}",
              "${yandex_compute_instance.zabbix-server.boot_disk.0.disk_id}",
              "${yandex_compute_instance.kibana.boot_disk.0.disk_id}",
              "${yandex_compute_instance.elasticsearch.boot_disk.0.disk_id}"]
}

# Формирование файла inventory.ini

resource "local_file" "inventory" {
  content  = <<-EOT
    [bastion]
    ${yandex_compute_instance.bastion-host.network_interface.0.ip_address} ip_bastion=${yandex_compute_instance.bastion-host.network_interface.0.ip_address} public_ip=${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address} ansible_hostname=bastion ansible_user=bastion

    [web_servers]
    ${yandex_compute_instance.web-server-1.network_interface.0.ip_address} ansible_user=user
    ${yandex_compute_instance.web-server-2.network_interface.0.ip_address} ansible_user=user

    [web_server_1]
    ${yandex_compute_instance.web-server-1.network_interface.0.ip_address} ansible_hostname=web-server-1 ansible_user=user

    [web_server_2]
    ${yandex_compute_instance.web-server-2.network_interface.0.ip_address} ansible_hostname=web-server-2 ansible_user=user

    [zabbix]
    ${yandex_compute_instance.zabbix-server.network_interface.0.ip_address} ip_zabbix=${yandex_compute_instance.zabbix-server.network_interface.0.ip_address} ansible_hostname=zabbix-server ansible_user=user

    [elasticsearch]
    ${yandex_compute_instance.elasticsearch.network_interface.0.ip_address} ansible_hostname=elasticsearch-server ansible_user=user

    [kibana]
    ${yandex_compute_instance.kibana.network_interface.0.ip_address} public_ip=${yandex_compute_instance.kibana.network_interface.0.nat_ip_address} ip_kibana=${yandex_compute_instance.kibana.network_interface.0.ip_address} ansible_hostname=kibana-server ansible_user=user

    [all:vars]
    ansible_ssh_common_args='-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o ProxyCommand="ssh -p 22 -W %h:%p -q bastion@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'
    zabbix_ext_ip=${yandex_compute_instance.zabbix-server.network_interface.0.nat_ip_address}
    zabbix_int_ip=${yandex_compute_instance.zabbix-server.network_interface.0.ip_address}
    elasticsearch_ip=${yandex_compute_instance.elasticsearch.network_interface.0.ip_address}

    EOT
  filename = "../ansible/inventory.ini"
}
