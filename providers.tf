provider "aws" {
  region = var.aws_reg
  # version = "2.12.0"
  profile = "formation"
  default_tags {
    tags = {
      Project = "wp_blog_202108_02"
    }
  }
}

provider "template" {
  #version = "~> 2.1.2"
}


