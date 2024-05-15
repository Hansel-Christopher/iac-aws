variable "name" {
  type        = string
  default     = "eks"
  description = "Name of the eks cluster"
}

variable "enable_eks_monitoring" {
  type        = bool
  default     = false
  description = "Flag to disable/enable the CW eks monitoring"
}

variable "cluster_version" {
  type        = string
  default     = "1.29"
  description = "Cluster version to bootstrap with"
}

variable "node_group_ami_type" {
  type        = string
  default     = "BOTTLEROCKET_x86_64"
  description = "Nodegroup AMI type"
}

variable "node_group_platform" {
  type        = string
  default     = "bottlerocket"
  description = "Node group platform type"
}

variable "instance_types" {
  type        = list(string)
  default     = ["t4.large"]
  description = "List of instance types to be used for the nodegroups"
}

variable "ng_min_size" {
  type        = number
  default     = 1
  description = "Node group minimum node count"
}

variable "ng_max_size" {
  type        = number
  default     = 1
  description = "Node group maximum node count"
}

variable "ng_desired_size" {
  type        = number
  default     = 1
  description = "Node group desired node count"
}

variable "taints" {
  type        = list(any)
  default     = []
  description = "Taints to be applied on the nodes"
}

variable "sns_notification_arn" {
  type    = list(string)
  default = []
}

variable "vpc_id" {
  type = string
}

variable "control_plane_subnet_ids" {
  type = list(string)
}

variable "node_group_subnet_ids" {
  type = list(string)
}
