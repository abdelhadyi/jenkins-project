pipeline {
    agent {
        label maven
    }
    tools {
        maven maven3
    }
    stages {
        stage("trivy fs") {
            steps {
                sh 'trivy fs --exit-code 1 --severity HIGH,CRITICAL .'
            }
        }
        stage('Build & Sonar') {
            steps {
                withCredentials([string(credentialsId: 'sonarqube-token-new', variable: 'sonar-token')]) {
                sh 'mvn clean verify sonar:sonar \
                -Dsonar.projectKey=jenkins-project \
                -Dsonar.host.url="http://${SONAR_IP}:9000" \
                -Dsonar.token="${sonar-token}" \
                -Dsonar.qualitygate.wait=true'
                }
            }
        }
    }
}