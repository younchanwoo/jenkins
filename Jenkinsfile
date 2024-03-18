pipeline {
    agent any

    environment {
        TOMCAT_URL = 'http://localhost:8081/'
        TOMCAT_USER = 'admin'
        TOMCAT_PASSWORD = 'admin'
        WAR_FILE = 'target/*.war'
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/younchanwoo/jenkins.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                script {
                    sh """
                    curl -u ${TOMCAT_USER}:${TOMCAT_PASSWORD} \
                    --upload-file ${WAR_FILE} \
                    "${TOMCAT_URL}/manager/text/deploy?path=/simple&update=true"
                    """
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment successful.'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
