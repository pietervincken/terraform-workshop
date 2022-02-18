variable "name" {
  type        = string
  description = "name of the participant"
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "Region to put all of the resources in"
}

variable "common_tags" {
  type        = map(any)
  description = "map of all tags for the resources"
}

variable "email" {
  type        = string
  description = "email of participant"
}
