//Create zone
//Create A record for IP
//Create LB and TG to have possibility to point to whole ASG not to the single instance
data "aws_instances" "asg_instances" {
  instance_tags = {
    Name = aws_ecs_cluster.dna.name
  }

  depends_on = [
    aws_autoscaling_group.ecs
  ]
}

resource "aws_route53_zone" "primary" {
  name = "cloverland.pl"
}

//TODO it is kinda hacky right now, because, even if I have depends on within aws_instances,
//usually ASG have no enough time to spin instances and terraform failed for the first time here
//however second try solves all the issues
// ALB and TG need to be implemented here, but then maybe cloudfront is better approach
resource "aws_route53_record" "simple_app" {
  name    = "dna"
  type    = "A"
  zone_id = aws_route53_zone.primary.zone_id
  records = data.aws_instances.asg_instances.public_ips
  ttl     = 300
}