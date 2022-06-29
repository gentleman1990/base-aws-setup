resource "aws_lb" "dna" {
  name               = "dna-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.vpc.default_security_group_id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = true

//  access_logs {
//    bucket  = aws_s3_bucket.lb_logs.bucket
//    prefix  = "test-lb"
//    enabled = true
//  }

  tags = {
    owner = "DNA Team"
    deployer = "Jakub Socha"
    stage = "test"
  }
}

resource "aws_lb_target_group" "dna" {
  name     = "dna-base-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
}

resource "aws_lb_listener" "dna" {
  load_balancer_arn = aws_lb.dna.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.dna.arn
  }
}

resource "aws_autoscaling_attachment" "dna" {
  autoscaling_group_name = aws_autoscaling_group.ecs.id
  lb_target_group_arn = aws_lb_target_group.dna.arn
}