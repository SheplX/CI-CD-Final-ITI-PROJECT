pipeline {
  agent { label 'slave' }
  stages {
    stage('start') {
      steps {
        script {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
              docker login -u ${USERNAME} -p ${PASSWORD}
              docker build -t shepl/app:latest .
              docker push shepl/app:latest
          """
        }
        
      }
      }
      
    }
    stage('Deploy') {
      steps {
       script {
        withCredentials([file(credentialsId: 'cluster_credintials', variable: 'config_file')]) {
          sh """
              gcloud container clusters get-credentials gp-cluster --region europe-west1 --project iti-project-340821
              kubectl apply -f .
          """
        }
        
      }
      }
    }
  }
}