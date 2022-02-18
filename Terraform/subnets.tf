 
resource "google_compute_subnetwork" "main_subnet" {
  name          = "main-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "europe-west1"
  network       = google_compute_network.gp-vpc.id
}

resource "google_compute_router" "router" {
  name    = "router"
  region  = google_compute_subnetwork.main_subnet.region
  network = google_compute_network.gp-vpc.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.main_subnet.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

resource "google_service_account" "private-vm-sa" {
  account_id   = "private-vm-sa"
  display_name = "mv-service-account"
}

resource "google_project_iam_binding" "vm-project" {
  project = "iti-project-340821"
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.private-vm-sa.email}"
  ]
}

resource "google_compute_instance" "ansible_vm" {
  name         = "ansible-vm"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-pro-cloud/ubuntu-pro-2004-lts"
    }
  }
  network_interface {
    network    = google_compute_network.gp-vpc.id
    subnetwork = google_compute_subnetwork.main_subnet.id
  }
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.private-vm-sa.email
    scopes = ["cloud-platform"]
  }
}