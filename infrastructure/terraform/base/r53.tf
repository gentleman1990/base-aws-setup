//Create zone
//Create A record for IP
//Create LB and TG to have possibility to point to whole ASG not to the single instance

resource "aws_route53_zone" "primary" {
  name = "cloverland.pl"
}