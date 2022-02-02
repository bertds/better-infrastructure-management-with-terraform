variable "instance_type" {
  type = string
}
 
variable "notebook_name" {
  type = string
}

variable "ip_addresses" {
  type    = list(string)
}