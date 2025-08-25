terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

resource "yandex_kubernetes_cluster" "test_cluster" {
    name = var.master_name

    network_id = var.vpc_net_id

    master {
        version = var.k8s_version
        
        dynamic "zonal" {
            for_each = var.is_regional ? [] : [1]

            content {
                zone = keys(var.map_zone_subids)[0]  #
                subnet_id = var.map_zone_subids[keys(var.map_zone_subids)[0]]
            }
        }


        dynamic "regional" {
            for_each = var.is_regional ? [1] : []

            content {
                region = "ru-central1"
                dynamic "location" {
                    for_each = var.map_zone_subids
                    content {
                        zone = location.key
                        subnet_id = location.value
                    }
                }

            }
        }

        public_ip = var.is_public

        maintenance_policy {
            auto_upgrade = var.auto_upgrade

            maintenance_window {
                start_time = var.update_start
                duration = var.update_duration
            }
        }
    }

    service_account_id = var.service_acc_id
    node_service_account_id = var.puller_id
}