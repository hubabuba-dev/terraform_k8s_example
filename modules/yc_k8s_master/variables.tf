variable "master_name" {
    description = "K8s master name"
    type = string
    default = "k8s_train_master"
}

variable "vpc_net_id" {
    description = "VPC network id"
    type = string
}

variable "k8s_version" {
    description = "Version of kubernetes"
    type = string
    default = "1.32"
}

variable "auto_upgrade" {
    description = "Does k8s need to be auto ubgraded"
    type = bool
    default = true
}

variable "update_start" {
    description = "Time when update will start"
    type = string 
    default = "00:00"
}

variable "update_duration" {
    description = "Time duration when cluster is abailable for update after update_start"
    type = string
    default = "4h"
}

variable "service_acc_id" {
    description = "Service account id for controling k8s"
    type = string
}

variable "puller_id" {
    description = "Service account id that will be used for pulling images"
    type = string
}

variable "is_public" {
    description = "Does we need public IP"
    type = bool
    default = false
}

variable "is_regional" {
    description = "For creating regional cluster"
    type = bool
    default = false
}

variable "map_zone_subids" {
    description = "Object with zone subnet_id mapping"
    type = map(string)
}