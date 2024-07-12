resource "aws_s3_bucket" "assignment_s3_bucket" {
 bucket = "sdlc-${var.cloud_env}-${var.bucket_name}"
}

resource "aws_s3_bucket_versioning" "assignment_s3_versioning" {
 bucket = aws_s3_bucket.assignment_s3_bucket.id
 versioning_configuration {
  status = "Enabled"
 }
}
