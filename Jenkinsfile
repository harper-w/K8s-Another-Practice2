pipeline {
    agent any
    stages {
        stage('Init') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh '''
                        kubectl create ns prod || echo "------- Prod Namespace Already Exists -------"
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh '''
                        kubectl create ns dev || echo "------- Prod Namespace Already Exists -------"
                        '''
                    } else {
                        sh'echo "Unrecogognised branch"'
                    }
                }
            }
        }
        stage('Build') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh '''
                        docker build -t harper1105/duo-jenk:latest -t harper1105/duo-jenk:v${BUILD_NUMBER} .
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh '''
                        docker build -t harper1105/duo-jenk:latest -t harper1105/duo-jenk:v${BUILD_NUMBER} .
                        '''
                    } else {
                        sh'echo "Unrecogognised branch"'
                    }
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh '''
                        docker push harper1105/duo-jenk:latest
                        docker push harper1105/duo-jenk:v${BUILD_NUMBER}
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh '''
                        docker push harper1105/duo-jenk:latest
                        docker push harper1105/duo-jenk:v${BUILD_NUMBER}
                        '''
                    } else {
                        sh'echo "Unrecogognised branch"'
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/main') {
                        sh'''
                        kubectl apply -f ./K8s -n prod
                        kubectl set image deployment/flask-deployment flask-container=harper1105/duo-jenk:v${BUILD_NUMBER} -n prod
                        '''
                    } else if (env.GIT_BRANCH == 'origin/dev') {
                        sh'''
                        kubectl apply -f ./K8s -n dev
                        kubectl set image deployment/flask-deployment flask-container=harper1105/duo-jenk:v${BUILD_NUMBER} -n dev
                        '''
                    } else {
                        sh'echo "Unrecogognised branch"'
                    }
                }
            }
        }
    }
}