variable "environment" {
  type        = string
  description = "Environment name (prod, dev, etc)"
}

variable "tags" {
  type        = map(string)
  description = "Common resource tags"
}