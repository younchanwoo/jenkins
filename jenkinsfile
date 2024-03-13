pipeline {
    agent any

    environment {
        // JBoss CLI 경로를 주어진 새로운 위치로 변경
        JBOSS_CLI = '/jboss/domains/a01/bin/jboss-cli.sh'
        JBOSS_SERVER = 'localhost:9990' // JBoss 관리 인터페이스 주소, 필요에 따라 조정
        DEPLOYMENT_NAME = 'simple.war' // 배포할 애플리케이션 WAR 파일명, 실제 파일명에 맞게 조정
        GIT_REPO = 'https://github.com/younchanwoo/jenkins.git'
    }

    stages {
        stage('Checkout') {
            steps {
                // Git 저장소에서 소스 코드 체크아웃
                git url: "${env.GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                script {
                    // Maven을 사용하여 프로젝트 빌드, Maven이 설치되어 있고, pom.xml 파일이 저장소에 있는 경우
                    sh 'mvn clean package'
                }
            }
        }

        stage('Deploy to JBoss') {
            steps {
                script {
                    // JBoss CLI를 사용하여 JBoss 서버에 배포
                    sh "${env.JBOSS_CLI} --connect controller=${env.JBOSS_SERVER} --commands='deploy target/${env.DEPLOYMENT_NAME} --force'"
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment Successful.'
        }
        failure {
            echo 'Deployment Failed.'
        }
    }
}
