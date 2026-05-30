terraform {
  required_version = ">= 1.0"
  required_providers {
    mgc = {
      source = "magalucloud/mgc"
    }
  }
}

provider "mgc" {
  api_key = var.api_key
  region  = var.region
}