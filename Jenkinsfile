pipeline {
    agent any 

    tools {
        jdk 'JDK'
        maven 'Maven'
    }
    
    environment{
        SCANNER_HOME=tool 'sonar-scanner'
    }

    stages{
        stage('Clean WorkSpace'){
            steps{
                cleanWs()
            }
        }
        stage('Git Check Out'){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Ravitejadarla5/DevSecOps-Continuous-Delivery-Application-on-Tomcat.git']])
            }
        }
        stage('Code Compile'){
            steps{
                sh 'mvn clean compile'
            }
        }
        stage('Unit Test'){
            steps{
                sh 'mvn test'
            }
        }
        stage('Sonar Analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialId: 'sonar-token'){
                        sh 'mvn sonar:sonar'
                        sh "$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=DevSecOps-Continuous-Delivery-Application -Dsonar.java.binaries=. -Dsonar.projectKey=DevSecOps-Continuous-Delivery-Application"
                    }
                }
            }
        }
    }
}