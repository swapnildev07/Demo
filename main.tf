provider "google" {
  project = "poc-project-439409"
  region  = "asia-south1"
}

# Define the region variable
variable "region" {
  description = "The region to host the Kubernetes cluster"
  type        = string
  default     = "asia-south1"  # Modify as per your desired region
}

resource "google_container_cluster" "k8s_cluster" {
  name               = "webapp-cluster"
  location           = var.region
  initial_node_count = 1

  # Node configuration
  node_config {
    machine_type = "e2-medium"
    disk_type    = "pd-standard"
  }
}

# Output kubeconfig
output "kubeconfig" {
  value = <<-EOF
  apiVersion: v1
  clusters:
  - cluster:
      server: https://${google_container_cluster.k8s_cluster.endpoint}
      certificate-authority-data: ${google_container_cluster.k8s_cluster.master_auth[0].cluster_ca_certificate}
    name: ${google_container_cluster.k8s_cluster.name}
  contexts:
  - context:
      cluster: ${google_container_cluster.k8s_cluster.name}
      user: ${google_container_cluster.k8s_cluster.name}
    name: ${google_container_cluster.k8s_cluster.name}
  current-context: ${google_container_cluster.k8s_cluster.name}
  kind: Config
  preferences: {}
  users:
  - name: ${google_container_cluster.k8s_cluster.name}
    user:
      auth-provider:
        config:
          cmd-args: config config-helper --format=json
          cmd-path: gcloud
          expiry-key: '{.credential.token_expiry}'
          token-key: '{.credential.access_token}'
        name: gcp
  EOF
}
