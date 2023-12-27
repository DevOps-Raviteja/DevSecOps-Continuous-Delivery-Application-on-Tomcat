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
                // junit '**/target/surefire-reports/*.xml'
            }
        }
        stage('Sonar Analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialId: 'sonar-token'){
                        sh 'mvn sonar:sonar'
                        sh "$SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=webApplication -Dsonar.java.binaries=. -Dsonar.projectKey=webApplication"
                    }
                }
            }
        }
        stage('Quality Gates'){
            steps{
                script{
                    waitForQualityGate abortPipeline:false, credentialsId: 'sonar-token'
                }
            }
        }
        stage('Package Install'){
            steps{
                sh 'mvn clean install'
                archiveArtifacts artifacts: 'target/*.war', followSymlinks: false
            }
        }
        // stage('Dependency-Check'){
        //     steps{
        //         dependencyCheck additionalArguments: '--scan ./ --format HTML', odcInstallation: 'DP-Check'
        //         dependencyCheckPublisher pattern: '**/dependency-check-report.html'
        //     }
        // }
        // stage('Deploy to Tomcat'){
        //     steps{
        //         sshagent(['tomcat-key']){
        //             sh 'scp -v -o StrictHostKeyChecking=no target/*.war ubuntu@54.165.96.106:/opt/tomcat/webapps'
        //         }
        //     }
        // }
    }
}