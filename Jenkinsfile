pipeline {
  agent { label 'slave' }
  stages {
    stage('start') {
      steps {
        script {
        withCredentials([usernamePassword(credentialsId: 'dockerhub_id', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
          sh """
              docker login -u ${env.USERNAME} -p ${env.PASSWORD}
              docker build -t shepl/app:latest .
              docker push shepl/app:latest
          """
        }
      }
      }
    }
  }
}
