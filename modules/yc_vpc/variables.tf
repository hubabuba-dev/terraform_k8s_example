variable "network_name" {
    description = "Name of VPC network"
    type = string
}

variable "folder_id" {
    description = "Folder id"
    type = string
    default = null
}

variable "map_zone_cidrs" {
    description = "Cidr of the subnet"
    type = map(list(string))
    default = {   
        "ru-central1-a" = ["192.168.10.0/24"]
    }

    validation {
        condition = alltrue([for cidr in flatten (values(var.map_zone_cidrs)) : can(cidrhost(cidr, 0))])
        error_message = "All cidrs must be valid IPv4"
    }

}

