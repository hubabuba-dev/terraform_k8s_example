variable "platform_id" {
    description = "id of platform"
    type = string
}

variable "k8s_version" {
    description = "Version of kubernetes"
    type = string
    default = "1.32"
}

variable "cluster_id" {
    description = "k8s cluster id"
    type = string
}

variable "group_name" {
    description = "Nodes group name"
    type = string
}

variable "is_nat" {
    description = ""
    type = bool
}

variable "specs" {
    description = "Object with cores and ram_gb number"
    type = object({
        cores = number
        memory = number
    })
}

variable "map_zone_subids" {
    description = "Object with zone subnet_id mapping"
    type = map(string)
}

variable "boot_disk" {
    description = ""
    type = object(
        {
            disk_type = string
            disk_size = number
        }
    )
}

variable "is_preemptible" {
    description = ""
    type = bool
}

variable "container_runtime" {
    description = ""
    type = string
}

variable "is_scalable" {
    description = ""
    type = bool
}

variable "size" {
    description = ""
    type = number
}

variable "is_auto" {
    description = ""
    type = bool
}

variable "is_repair" {
    description = ""
    type = bool
}