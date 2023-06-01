resource "aws_cloudfront_distribution" "jumpv" {
  origin {
    domain_name = aws_lb.jumpv.dns_name
    origin_id   = "elb-origin"
  }

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "elb-origin"
    viewer_protocol_policy = "redirect-to-https" # other options - https only, http
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    
  }

  origin {
    domain_name = aws_lb.jumpv.dns_name
    origin_id   = "elb-origin"
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "My CloudFront distribution"
  default_root_object = "index.html"
  price_class         = "PriceClass_All"
  
  

  viewer_certificate {
   
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Add a custom error page for HTTP 404 (Not Found) errors
#  custom_error_response {
#    error_caching_min_ttl = 60
#    error_code            = 404
#    response_code         = 200
#    response_page_path    = "/404.html"
#  }
}
