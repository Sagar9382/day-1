variable "nics" {
  description = "Map of Network Interfaces to create"
  type        = any
}

variable "subnets" {
  description = "Map of created subnets output"
  type        = any
  default     = {}
}

variable "public_ips" {
  description = "Map of created public IPs output"
  type        = any
  default     = {}
}

variable "nsgs" {
  description = "Map of created network security groups output"
  type        = any
  default     = {}
}
