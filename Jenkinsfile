pipeline {
  agent { label 'slave' }
  stages {
        stage('Deploy') {
      steps {
       script {
        withCredentials([file(credentialsId: 'cluster_id', variable: 'KUBECONFIG')]) {
          sh """
              gcloud container clusters get-credentials my-gke-cluster --region europe-west2 --project lustrous-maxim-341315
          """
        }
      }
      }
    }
  }
}
