pipeline {
    agent any

    tools {
        // Maven 설정. Jenkins에 정의된 Maven 도구의 이름을 사용해야 함.
        maven "Maven" // Jenkins 설정에 따라 적절히 변경
    }

    environment {
        // 환경 변수 설정
        JBOSS_CLI = '/jboss/domains/a01/bin/jboss-cli.sh'
        JBOSS_SERVER = 'localhost:9990' // JBoss 관리 인터페이스 주소, 실제 환경에 맞게 조정
        DEPLOYMENT_NAME = 'simple.war' // 실제 파일명에 맞게 조정
    }

    stages {
        stage('Checkout') {
            steps {
                // Git 저장소에서 소스 코드 체크아웃
                git url: 'https://github.com/younchanwoo/jenkins.git'
            }
        }

        stage('Build') {
            steps {
                // Maven을 사용하여 프로젝트 빌드
                sh 'mvn clean package'
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
