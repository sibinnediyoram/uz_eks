#VPC#
variable "iac_environment_tag" {
  type        = string
  description = "AWS tag to indicate environment name of each infrastructure object."
}

variable "profile" {
    default = "default"
    }

variable "region" {
    default = "eu-central-1"
}

variable "workspace_key_prefix" {
}

variable "environment" {
    default = "dev"
    }

variable "cidr" {
  default = "10.0.0.0/16"
}

data "aws_availability_zones" "available" {
}

variable "private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}
variable "public_subnets" {
  default = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}  
variable "enable_nat_gateway" {
  default = "true"
} 
variable "enable_vpn_gateway" {
  default = "true"
} 

variable "enable_dns_hostnames" {
    default = "true"
}

variable "single_nat_gateway" {
    default = "true"
}

#EKS#

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

variable "instance_type" {
}

variable "asg_desired_capacity" {
}

variable "asg_max_capacity" {
    
}

variable "asg_min_capacity" {
    
}

variable "w1_instance_type" {
    default = "t3.medium"
}

variable "w1_asg_desired_capacity" {
    default = 1 
}

variable "w1_asg_max_capacity" {
    default = 5
}

variable "w1_asg_min_capacity" {
    default = 1
}

variable "k8s_cluster_version" {
    default = "1.17"
}

#SG#
variable "cidr_blocks_one" {
    default = ["10.0.0.0/8",]
}