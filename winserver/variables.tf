variable "servername" {
    description = "Name of the Server"
    type = string
}

variable "rgname" {
    description = "Resource group name"
    type = string
}

variable "location" {
    description = "Location"
    type = string
}

variable "subnetid" {
    description = "ID of the subnet"
    type = string
}

variable "nsgid" {
    description = "ID of the Network Security Group"
    type = string
}