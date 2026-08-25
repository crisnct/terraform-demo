terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.85.0"
    }
  }
}

variable "region" {
  default = "us-east1"
}

variable "zone" {
  default = "us-east1-c"
}

provider "google" {
  project     = "gen-lang-client-0640093980"
  region      = var.region
  zone        = var.zone
  credentials = "keys.json"
}










