pipeline {
  agent { label 'slave' }
  stages {
    stage('Building Our Application .... ') {
      steps {
        script {
        withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
              docker login -u ${env.USERNAME} -p ${env.PASSWORD}
              docker build -t shepl/python_app:latest .
              docker push shepl/python_app:latest
          """
        }
      }
      }
    }
    stage('Deploying It Using Cluster .... ') {
      steps {
       script {
        withCredentials([file(credentialsId: 'k8s_id', variable: 'KUBECONFIG')]) {
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
