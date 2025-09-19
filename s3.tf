
resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "my-sumith-terraform-bucket"

  tags = {
    Name        = "My-sumith-terraform-bucket"
    Environment = "Dev"
  }
}
