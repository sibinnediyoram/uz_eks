provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.11"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = var.tfstate_bucket
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_public_access_block" "terraform_state_access" {
  bucket = aws_s3_bucket.terraform_state.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tf-table"
  read_capacity  = 1
  write_capacity = 1
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "12.2.0"

  cluster_name    = "${var.environment}-cluster"
  cluster_version = var.k8s_cluster_version
  subnets         = module.vpc.private_subnets
  cluster_enabled_log_types     =  ["api", "audit", "controllerManager", "authenticator", "scheduler"]
  cluster_log_retention_in_days = 7
  vpc_id = module.vpc.vpc_id
  write_kubeconfig   = true
  config_output_path = "./"
  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }
  tags = {
    Environment = terraform.workspace
  }
  node_groups = {
    platform = {
      name = "platform"
      desired_capacity = var.asg_desired_capacity
      max_capacity     = var.asg_max_capacity
      min_capacity     = var.asg_min_capacity
      instance_type = var.instance_type
      k8s_labels = {
        Environment = terraform.workspace
        NodeGroup   = "platform"
      }
    }
  }

   workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = var.w1_instance_type
      asg_desired_capacity          = var.w1_asg_desired_capacity
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    }
  ]

}
