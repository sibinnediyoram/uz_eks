
resource "aws_security_group" "worker_group_mgmt_one" {
  name_prefix = "worker_group_one"
  vpc_id      = module.vpc.vpc_id

  ingress  {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = var.cidr_blocks_one
  } 
    egress     {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }

  }

resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress  {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = var.cidr_blocks_one
  } 
  egress    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  
}
