pipeline {
    agent {
        kubernetes {
            yamlFile 'k8s-smart-mvn-pod.yaml'
        }
    }

    environment {
        KUBECONFIG = credentials('k8s.s3t.co')
    }

    stages {
        stage('prepare') {
            steps {
                script {
                    version = "1.0.${BUILD_NUMBER}"
                }
            }
        }
        
        stage("build") {
            steps {
                container("smart-mvn-agent") {
                    withCredentials([usernamePassword(credentialsId: "yycelik.github.com", usernameVariable: "USERNAME0", passwordVariable: "PASSWORD0"),
                                     usernamePassword(credentialsId: "mysql.s3t.co", usernameVariable: "USERNAME2", passwordVariable: "PASSWORD2")]) {
                        sh """
                            git clone https://$USERNAME0:$PASSWORD0@github.com/yycelik/smart-user-api.git

                            export DATASOURCE_USERNAME="$USERNAME2"

                            export DATASOURCE_PASSWORD="$PASSWORD2"

                            cd smart-user-api

                            mvn versions:set -DnewVersion=${version} --batch-mode -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn

                            mvn install -P create-image -DskipTests --batch-mode -Dorg.slf4j.simpleLogger.log.org.apache.maven.cli.transfer.Slf4jMavenTransferListener=warn
                        """
                    }
                }
            }
        }
        
        stage("deploy") {
            steps {
                container("smart-skaffold-agent") {
                    withCredentials([usernamePassword(credentialsId: "nexus.s3t.co", usernameVariable: "USERNAME1", passwordVariable: "PASSWORD1"),
                                     usernamePassword(credentialsId: "mysql.s3t.co", usernameVariable: "USERNAME2", passwordVariable: "PASSWORD2")]) {
                        sh """
                            export DATASOURCE_USERNAME="$USERNAME2"

                            export DATASOURCE_PASSWORD="$PASSWORD2"

                            cd smart-user-api

                            echo "################### ${version}"
                            skaffold deploy --namespace=smart --images=docker-r.nexus.s3t.co/smart/user:${version} --profile=prod
                        """
                    }
                }
            }
        }
    }
}
