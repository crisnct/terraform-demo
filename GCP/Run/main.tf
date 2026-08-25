resource "google_cloud_run_service" "run-app-from-tf" {
  name = "run-app-from-tf"
  location = "asia-southeast1"
  
  template {
    spec {
      containers {
        image = "gcr.io/google-samples/hello-app:1.0"
        #image = "us-docker.pkg.dev/cloudrun/container/hello:2.0"
      }
    }
  }

  # traffic {
  #   revision_name = "run-app-from-tf-00003-xk7"
  #   percent = 50
  # }
  # traffic {
  #   revision_name = "run-app-from-tf-00001-gpv"
  #   percent = 50
  # }


  
}


resource "google_cloud_run_service_iam_policy" "pub_access" {
  service = google_cloud_run_service.run-app-from-tf.name
  location = google_cloud_run_service.run-app-from-tf.location
  policy_data = data.google_iam_policy.pub-1.policy_data
}

data "google_iam_policy" "pub-1" {
  binding {
    role = "roles/run.invoker"
    members = [ "allUsers", ]
  }
}
