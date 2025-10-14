variable "vpc_config" {
  description = "Provide CIDR block and a tag"
  type = object({
    cidr_block = string
    Name       = string
  })
  validation {
    condition     = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR format-${var.vpc_config.cidr_block}"
  }
}

variable "subnet_Config" {
  description = "Get CIDR and AZ's "
  type = map(object({
    cidr_block = string
    AZ         = string
    public=optional(bool,false)
  }))
  validation {

    condition     = alltrue([for k, v in var.subnet_Config : can(cidrnetmask(v.cidr_block))])
    error_message = "Each subnet's cidr_block must be a valid CIDR string"
  }
}
