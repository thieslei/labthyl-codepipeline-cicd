resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = "${var.project}-artifacts"
  acl    = "private"
  versioning {
    enabled = false
  }
  force_destroy = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  tags = {
    description = "S3 for code artifacts"
    owner       = var.owner
    environment = var.environment
    project     = var.project
  }
} 