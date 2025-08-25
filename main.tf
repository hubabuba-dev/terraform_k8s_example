terraform {
    required_providers {
        yandex = {
            source = "yandex-cloud/yandex"
        }
    }
    required_version = ">= 0.13"
}

provider "yandex" {
    zone = ""
    folder_id = ""
}

data "yandex_iam_service_account" "sa" {
    name = ""
}

data "yandex_iam_service_account" "sa_puller" {
    name = ""
}

module "yc_vpc" {
    source = "./modules/yc_vpc"

    folder_id = ""

    network_name = "test_vpc"
    map_zone_cidrs = {  
        "ru-central1-a" = ["192.168.10.0/24"]
    }
}

module "yc_k8s_master" {
    source = "./modules/yc_k8s_master"

    master_name = "learning-k8s"
    k8s_version = "1.32"

    is_regional = false
    vpc_net_id = module.yc_vpc.vpc_net_id
    map_zone_subids = module.yc_vpc.map_zone_subids
    is_public = false

    auto_upgrade = true
    update_start = "00:00"
    update_duration = "4h"

    service_acc_id = data.yandex_iam_service_account.sa.id
    puller_id = data.yandex_iam_service_account.sa_puller.id
}


module "yc_k8s_nodes" {
    source = "./modules/yc_k8s_nodes"

    platform_id = "standard-v1"
    cluster_id = module.yc_k8s_master.cluster_id
    k8s_version = "1.32"

    group_name = "test-nodes"

    is_nat = false
    map_zone_subids = module.yc_vpc.map_zone_subids

    specs = {
        cores = 2
        memory = 2
    }
    boot_disk = {
        disk_type = "network-hdd"
        disk_size = 64
    }

    is_preemptible = false

    container_runtime = "containerd"

    is_scalable = false

    size = 1

    is_auto = false
    is_repair = false


}