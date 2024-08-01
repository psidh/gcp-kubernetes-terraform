provider "google" {
  project = "YOUR_PROJECT_ID"
  region  = "YOUR_REGION"
}

resource "google_container_cluster" "primary" {
  name     = "primary-cluster"
  location = "YOUR_CLUSTER_ZONE"

  initial_node_count = 1

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  location   = google_container_cluster.primary.location
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = false
    machine_type = "e2-medium"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host = google_container_cluster.primary.endpoint

  token = data.google_client_config.default.access_token

  cluster_ca_certificate = base64decode(
    google_container_cluster.primary.master_auth.0.cluster_ca_certificate
  )
}

resource "kubernetes_deployment" "nodejs" {
  metadata {
    name = "nodejs-deployment"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "nodejs"
      }
    }

    template {
      metadata {
        labels = {
          app = "nodejs"
        }
      }

      spec {
        container {
          name  = "nodejs"
          image = "gcr.io/YOUR_PROJECT_ID/nodejs-app:latest"

          port {
            container_port = 3000
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "nodejs" {
  metadata {
    name = "nodejs-service"
  }

  spec {
    selector = {
      app = "nodejs"
    }

    port {
      port        = 80
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
  
