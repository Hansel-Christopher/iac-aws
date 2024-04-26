variable "name" {
  type        = string
  default     = "eks"
  description = "(optional) describe your variable"
}

variable "enable_eks_monitoring" {
  type        = bool
  default     = false
  description = "(optional) describe your variable"
}

variable "cluster_version" {
  type        = string
  default     = "1.29"
  description = "describe your variable"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t4.large"]
  description = "describe your variable"
}

variable "ng_min_size" {
  type        = number
  default     = 1
  description = "description"
}

variable "ng_max_size" {
  type        = number
  default     = 1
  description = "description"
}

variable "ng_desired_size" {
  type        = number
  default     = 1
  description = "description"
}

variable "taints" {
  type        = list(any)
  default     = []
  description = "(optional) describe your variable."
}

# [
#   {
#     key    = "dedicated"
#     value  = "gpuGroup"
#     effect = "NO_SCHEDULE"
#   }
# ]