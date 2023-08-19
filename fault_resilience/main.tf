terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
provider "yandex" {
  token = "y0_AgAAAAAC43QDAATuwQAAAADg-a2AjYYZahn-TeGcDKbikhY_39flG-U"
  cloud_id = "b1gnmn6d1boubivf2i66"
  folder_id = "b1grrus8dh3dcdtlcf2k"
  zone = "ru-central1-b"
}
resource "yandex_compute_instance" "vm-terraform" {
  count = 2
  name = "vm-terraform${count.index}"

  resources {
    cores  = 2
    memory = 2
  }
  boot_disk {
    initialize_params {
      image_id = "fd8rqervg4dejhr6fo35"
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }
  metadata = {
    user-data = "${file("./meta.yml")}"
  }
}
resource "yandex_vpc_network" "network-1" {
  name = "network1"
}
resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}
resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "lb-1"
  listener {
    name = "test-lb-1"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.test-1.id
    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
resource "yandex_lb_target_group" "test-1" {
  name           = "test-1"
  target {
    subnet_id    = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.vm-terraform[0].network_interface.0.ip_address
  }
  target {
    subnet_id    = yandex_vpc_subnet.subnet-1.id
    address   = yandex_compute_instance.vm-terraform[1].network_interface.0.ip_address
  }
}
