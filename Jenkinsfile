pipeline {
    agent {
        label 'maven'
    }
    tools {
        maven 'maven3'
    }
    environment {
        SONAR_IP = '34.196.124.198' 
    }
    stages {
        stage("trivy fs") {
            steps {
                sh 'trivy fs --exit-code 1 --severity HIGH,CRITICAL .'
            }
        }
        stage('Build & Verify') {
            steps {
                dir('maven-src') {
                    sh 'mvn clean verify'
                }
            }
        }
        stage('SonarQube Analysis') {
            steps {
                dir('maven-src') {
                    withCredentials([string(
                        credentialsId: 'sonarqube-token', 
                        variable: 'SONAR_TOKEN'
                    )]) {
                        sh '''
                            mvn sonar:sonar \
                            -Dsonar.projectKey=jenkins-project \
                            -Dsonar.host.url="http://${SONAR_IP}:9000" \
                            -Dsonar.token="${SONAR_TOKEN}" \
                            -Dsonar.qualitygate.wait=true
                        '''
                    }
                }
            }
        }
    }
}