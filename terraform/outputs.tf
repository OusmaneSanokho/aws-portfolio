output "cloudfront_domain_name" {
  description = "The public CloudFront domain that serves the site"
  value       = aws_cloudfront_distribution.portfolio.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID, needed later for cache invalidation in CI/CD"
  value       = aws_cloudfront_distribution.portfolio.id
}