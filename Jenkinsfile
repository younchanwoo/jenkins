pipeline {
    agent any

    tools {
        // Maven을 사용하여 프로젝트를 빌드하기 위해 Jenkins에서 정의된 Maven 도구 이름을 사용합니다.
        maven 'M3'
    }

    environment {
        // 배포될 Tomcat 서버의 정보를 환경 변수로 설정합니다.
        TOMCAT_URL = 'http://localhost:8081/manager'
        TOMCAT_USER = 'admin'
        TOMCAT_PASSWORD = 'admin'
        // WAR 파일의 위치를 지정합니다.
        WAR_FILE = 'target/simple.war'
    }

    stages {
        stage('Checkout') {
            steps {
                // Git 저장소에서 소스 코드를 체크아웃합니다.
                git 'https://github.com/younchanwoo/jenkins.git'
            }
        }

        stage('Build') {
            steps {
                // Maven을 사용하여 프로젝트를 클린 빌드하고 패키지합니다.
                sh 'mvn clean package'
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                script {
                    // 생성된 WAR 파일을 Tomcat 서버에 /simple 경로로 배포합니다.
                    sh """
                    curl -u ${TOMCAT_USER}:${TOMCAT_PASSWORD} \
                    --upload-file ${WAR_FILE} \
                    "${TOMCAT_URL}/deploy?path=/simple&update=true"
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
