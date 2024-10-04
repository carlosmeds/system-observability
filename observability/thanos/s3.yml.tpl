type: S3
config:
  bucket: "${bucket_name}"
  endpoint: "s3.amazonaws.com"
  region: "${aws_region}"
  access_key: "${aws_access_key}"
  secret_key: "${aws_secret_key}"
  insecure: false