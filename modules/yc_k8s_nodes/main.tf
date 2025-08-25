terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}


resource "yandex_kubernetes_node_group" "nodes" {
    for_each = var.map_zone_subids

    cluster_id = var.cluster_id
    name = var.group_name
    description = ""
    version = var.k8s_version


    instance_template {
        platform_id = var.platform_id

        network_interface  {
            nat = var.is_nat
            subnet_ids = [each.value]
        }

        resources {
            memory = var.specs.memory
            cores = var.specs.cores
        }

        boot_disk {
            type = var.boot_disk.disk_type
            size = var.boot_disk.disk_size
        }

        scheduling_policy {
            preemptible = var.is_preemptible
        }

        container_runtime {
            type = var.container_runtime
        }
    }

    scale_policy {
        dynamic "fixed_scale" {
            for_each = var.is_scalable ? [] : [1]

            content {
                size = var.size
            }
        }

        dynamic "auto_scale"{
            for_each = var.is_scalable ? [1] : []

            content {
                initial = var.auto_scale.initial
                max = var.auto_scale.max
                min = var.auto_scale.min
            }
        }
    }

    allocation_policy {
        location {
            zone = each.key
        }
    }


}