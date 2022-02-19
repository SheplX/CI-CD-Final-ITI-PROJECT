pipeline {
  agent { label 'slave' }
  stages {
        stage('Deploy') {
      steps {
       script {
        withCredentials([file(credentialsId: 'cluster_id', variable: 'KUBECONFIG')]) {
          sh """
              gcloud container clusters get-credentials gp-cluster --region europe-west1 --project iti-project-340821
          """
        }
      }
      }
    }
  }
}
