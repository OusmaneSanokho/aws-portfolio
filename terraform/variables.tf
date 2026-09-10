variable "bucket_name" {
  description = "Globally-unique name for the S3 bucket that stores the portfolio site files"
  type        = string
}

variable "tags" {
  description = "Common tags applied to every resource this project creates"
  type        = map(string)
  default = {
    Project   = "aws-portfolio"
    ManagedBy = "terraform"
  }
}