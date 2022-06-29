//TODO It is my first time with cloudfront :)

locals {
  id = "dnacf"
}

resource "aws_cloudfront_distribution" "dna" {
  enabled             = true
  aliases = [ "${local.id}.${aws_route53_zone.primary.name}" ]

  origin {
    domain_name = aws_route53_zone.primary.name
    origin_id   = local.id

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  price_class = "PriceClass_200"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    owner = "DNA Team"
    deployer = "Jakub Socha"
    stage = "test"
  }

  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.dna_cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }
}

resource "aws_acm_certificate" "dna_cert" {
  domain_name               = aws_route53_zone.primary.name
  subject_alternative_names = ["*.${aws_route53_zone.primary.name}"]
  validation_method         = "DNS"

  tags = {
    Name = aws_route53_zone.primary.name
  }
}

resource "aws_route53_record" "dna_cf" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = local.id
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.dna.domain_name
    zone_id                = aws_cloudfront_distribution.dna.hosted_zone_id
    evaluate_target_health = true
  }
}