pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh '''
                docker build -t harper1105/duo-jenk:latest -t harper1105/duo-jenk:v${BUILD_NUMBER} .
                '''
            }
        }
        stage('Push') {
            steps {
                sh '''
                docker push harper1105/duo-jenk:latest
                docker push harper1105/duo-jenk:v${BUILD_NUMBER}
                '''
            }
        }
        stage('Deploy') {
            steps {
                sh'''
                kubectl apply -f ./K8s

                kubectl set image deployment/flask-deployment flask-container=harper1105/duo-jenk:v${BUILD_NUMBER}
                '''
            }
        }
    }
}
