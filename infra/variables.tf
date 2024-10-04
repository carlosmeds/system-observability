variable "aws_access_key" {
  description = "AWS Access Key ID"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Access Key"
  type        = string
  sensitive   = true
}

variable "bucket_name" {
  description = "AWS S3 bucket name"
  type        = string
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
}

variable "s3_yaml_path" {
  description = "Path to the S3 configuration file"
  type        = string
  default     = "../observability/thanos/s3.yml"
}
