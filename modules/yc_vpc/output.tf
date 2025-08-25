output "vpc_net_id" {
    description = "ID of created VPC network"
    value = yandex_vpc_network.this.id
}

output map_zone_subids {
    description = "ID of created VPC subnet"
    value = {
    for zone, subnet in yandex_vpc_subnet.private : zone => subnet.id
  }
}