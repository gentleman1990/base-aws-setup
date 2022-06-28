//TODO I am start feeling that it is some kind of over engineering :P Maybe fargate will be enough there, maybe I can even use module for fargate from terraform registry

data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-*-amazon-ecs-optimized"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_launch_configuration" "ecs" {
  name_prefix   = "${aws_ecs_cluster.dna.name}-launch-cfg-"
  image_id      =  data.aws_ami.ecs.id
  instance_type = "t2.micro"
  key_name      = "dna-base-ssh-key"

  security_groups      = [module.vpc.default_security_group_id]

  lifecycle {
    create_before_destroy = true
  }

//  user_data = file("${path.module}/scripts/user-data.sh")
}

resource "aws_autoscaling_group" "ecs" {
  name_prefix          = "${aws_ecs_cluster.dna.name}-ag-"
  vpc_zone_identifier  = flatten(module.vpc.public_subnets)
  launch_configuration = aws_launch_configuration.ecs.name

  min_size         = 1
  max_size         = 2
  desired_capacity = 1

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    owner = "DNA Team"
    deployer = "Jakub Socha"
    stage = "test"
  }
}