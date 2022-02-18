resource "google_compute_network" "gp-vpc" {
  project                 = "iti-project-340821"
  name                    = "gp-vpc"
  auto_create_subnetworks = false
}