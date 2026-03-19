terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.11.1"
    }
    google = {
      source  = "hashicorp/google"
      version = "7.24.0"
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


resource "google_service_account" "gsa" {
  account_id = "cr-ollama"
  project    = var.project
}

resource "google_project_iam_member" "sa_role" {
  project = var.project
  role    = "roles/iam.serviceAccountUser"
  member  = format("serviceAccount:%s", google_service_account.gsa.email)
}

module "ollama" {
  source = "git::https://github.com/libops/terraform-cloudrun-v2?ref=0.5.1"

  name          = "ollama"
  project       = var.project
  gsa           = google_service_account.gsa.email
  max_instances = 7
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
  regions = ["us-east4"]
  providers = {
    google = google.default
  }
}
