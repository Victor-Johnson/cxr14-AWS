terraform {
  backend "s3" {
    bucket       = "cxr14-tfstate-c70a9673"
    key          = "bootstrap/terraform.tfstate"
    region       = "eu-west-2"
    encrypt      = true
    use_lockfile = true
  }
}
