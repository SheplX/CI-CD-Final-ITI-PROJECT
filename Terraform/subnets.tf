 
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

resource "google_compute_instance" "jenkins" {
  name         = "jenkins-slave"
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
 
 metadata_startup_script = <<SCRIPT
 
    #to install kubectl CLI
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl";
    curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256";
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl;

    #to get latest updated repos
    sudo apt-get update;
    
    #to install Ansible
    sudo apt-get install -y ansible;

    #to get latest updated repos
    sudo apt-get update;

    #to install pip3
    sudo apt -y install python3-pip;
    
    #to install required modules
    sudo pip install openshift pyyaml kubernetes;

    #to fix Ansible playbook errors
    sudo pip install -Iv kubernetes==11.0;
    
    #to install docker
    sudo apt update;
    sudo apt-get install apt-transport-https ca-certificates curl software-properties-common -y;
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu  $(lsb_release -cs)  stable";
    sudo apt update;
    sudo apt-get install docker-ce -y;
    sudo systemctl start docker;
    sudo systemctl enable docker;
    SCRIPT
 
}
