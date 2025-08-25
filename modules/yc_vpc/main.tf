terraform {
    required_providers {
        random = {
            source = "hashicorp/random"
            version = "~>3.0"
        }
            yandex = {
            source = "yandex-cloud/yandex"
            version = ">= 0.13"
        }
    }
}

resource "random_id" "subnet_suff" {
    byte_length = 2
}

resource "yandex_vpc_network" "this" {
    name = var.network_name
}

resource "yandex_vpc_subnet" "private" {
    for_each = var.map_zone_cidrs

    name = "${var.network_name}-subnet-${each.key}-${random_id.subnet_suff.hex}"
    zone = each.key
    v4_cidr_blocks = each.value
    network_id = yandex_vpc_network.this.id
}