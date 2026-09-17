variable "resource_groups" {
  description = "Map of resource groups"
  type        = any
  default     = {}
}

variable "vnets" {
  description = "Map of virtual networks"
  type        = any
  default     = {}
}

variable "subnets" {
  description = "Map of subnets"
  type        = any
  default     = {}
}

variable "public_ips" {
  description = "Map of public IPs"
  type        = any
  default     = {}
}

variable "nsgs" {
  description = "Map of network security groups"
  type        = any
  default     = {}
}

variable "nics" {
  description = "Map of network interfaces"
  type        = any
  default     = {}
}

variable "vms" {
  description = "Map of virtual machines"
  type        = any
  default     = {}
}