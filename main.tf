terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.7.5"
    }
    google = {
      source  = "hashicorp/google"
      version = "7.9.0"
    }
  }

  backend "gcs" {
    bucket = "lehigh-lyrasis-catalyst-terraform"
    prefix = "/mistral"
  }
}

provider "google" {
  alias   = "default"
  project = var.project
}


module "ollama" {
  source = "git::https://github.com/libops/terraform-cloudrun-v2?ref=0.3.3"

  name          = "ollama"
  project       = var.project
  max_instances = 1
  containers = tolist([
    {
      name   = "ollama",
      image  = "us-docker.pkg.dev/${var.project}/internal/mistral:main@${var.image_digest}"
      port   = 8080
      memory = "16Gi"
      cpu    = "4000m"
      gpus   = 1
    }
  ])
  skipNeg = true
  regions = ["us-central1"]
  providers = {
    google = google.default
  }
}
