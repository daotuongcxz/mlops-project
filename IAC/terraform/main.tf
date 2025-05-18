provider "google" {
  project = var.project_id
  credentials =  file("creadential_terrform.json")
  region = var.region
}

// Google Cloud Storage
// https://cloud.google.com/storage/docs/terraform-create-bucket-upload-object
// or refer to https://registry.terraform.io/providers/hashicorp/google/latest/docs
resource "google_storage_bucket" "mlops_k6" {
  name          = var.bucket
  location      = var.region

  # Enable bucket level access
  uniform_bucket_level_access = true
}

// Google Compute Engine
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"
  zone =  var.zone

  tags = ["ssh-access"]

  boot_disk {
    initialize_params {
      image = "projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20230727"
    }
  }

  network_interface {
    network = "default"
    access_config {}  # Tạo IP public
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "google_compute_firewall" "jenkins_firewall" {
  name    = "allow-jenkins"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["jenkins-server"]
}

resource "google_compute_firewall" "default-allow-ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh-access"] 
}



// Google Kubernetes Engine
# resource "google_container_cluster" "gke_cluster_mlops" {
#   name     = "${var.project_id}-gke"
#   location = var.region

#   // Enabling Autopilot for this cluster
#   enable_autopilot = true
# }


