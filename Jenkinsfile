pipeline {
    agent {
        label 'maven'
    }
    tools {
        maven 'maven3'
    }
    environment {
        SONAR_IP = '34.196.124.198' 
        ecr_registry = '383189130746.dkr.ecr.us-east-1.amazonaws.com'
        repo = 'maven-app'
    }
    stages {
        stage("trivy fs") {
            steps {
                sh 'trivy fs --exit-code 1 --severity HIGH,CRITICAL .'
            }
        }
        stage('Build, Test & SonarQube') {
            steps {
                dir('maven-src') {
                    withCredentials([string(
                        credentialsId: 'sonarqube-token', 
                        variable: 'SONAR_TOKEN'
                    )]) {
                        sh '''
                            mvn clean verify org.sonarsource.scanner.maven:sonar-maven-plugin:5.2.0.4988:sonar \
                            -Dsonar.projectKey=jenkins-project \
                            -Dsonar.host.url="http://${SONAR_IP}:9000" \
                            -Dsonar.token="${SONAR_TOKEN}" \
                            -Dsonar.qualitygate.wait=true
                        '''
                    }
                }
            }
        }
        stage('build image'){
            steps{
                sh 'docker build -t ${ecr_registry}/{repo}:${BUILD_NUMBER} -t ${ecr_registry}/{repo}:latest .'
            }
        }
        stage('ECR-Login'){
            steps{
                sh 'aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 383189130746.dkr.ecr.us-east-1.amazonaws.com'
            }
        }
        stage('Push to ECR'){
            steps {
                sh 'docker push ${ecr_registry}/{repo}:${BUILD_NUMBER}'
                sh 'docker push ${ecr_registry}/{repo}:latest'                
            }
        }
    }
}