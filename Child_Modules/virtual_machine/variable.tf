variable "vms" {
  description = "Map of Virtual Machines to create"
  type        = any
}

variable "nics" {
  description = "Map of created network interfaces output"
  type        = any
  default     = {}
}
