resource "aws_s3_bucket" "test_object_store" {
  bucket = "test-object-store"
}

resource "aws_s3_bucket_public_access_block" "test_object_store" {
  bucket = aws_s3_bucket.test_object_store.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "blob" {
  bucket = aws_s3_bucket.test_object_store.bucket
  key    = "aws.webp"
  source = "upload/aws.webp"
  etag   = filemd5("upload/aws.webp")
}
