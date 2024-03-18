pipeline {
    agent any // This will allow the job to run on any available agent

    environment {
        // Set the environment variables for the Tomcat server where the app will be deployed.
        TOMCAT_URL = 'http://localhost:8081/'
        TOMCAT_USER = 'admin'
        TOMCAT_PASSWORD = 'admin'
        // Specify the location of the WAR file.
        WAR_FILE = 'target/*.war'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the source code from the Git repository.
                git 'https://github.com/younchanwoo/jenkins.git'
            }
        }

        stage('Build') {
            steps {
                // Use Maven to clean build and package the project.
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                script {
                    // Deploy the generated WAR file to the Tomcat server at the /simple path.
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
