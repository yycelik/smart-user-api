pipeline {
    agent {
        kubernetes {
            yamlFile 'k8s-smart-mvn-pod.yaml'
        }
    }

    environment {
        KUBECONFIG = credentials('smart_kube_config')
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
                                     usernamePassword(credentialsId: "nexus.s3t.co", usernameVariable: "USERNAME1", passwordVariable: "PASSWORD1"),
                                     usernamePassword(credentialsId: "mysql.s3t.co", usernameVariable: "USERNAME2", passwordVariable: "PASSWORD2")]) {
                        sh """
                            git clone https://$USERNAME0:$PASSWORD0@github.com/yycelik/smart-user-api.git

                            export REGISTRY_GROUP="docker-g.nexus.s3t.co"

                            export REGISTRY_PROXY="docker-p.nexus.s3t.co"

                            export REGISTRY_SNAPSHOOT="docker-s.nexus.s3t.co"

                            export REGISTRY_RELEASE="docker-r.nexus.s3t.co"

                            export REGISTRY_USERNAME="$USERNAME1"

                            export REGISTRY_PASSWORD="$PASSWORD1"

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
                            export REGISTRY_GROUP="docker-g.nexus.s3t.co"

                            export REGISTRY_PROXY="docker-p.nexus.s3t.co"

                            export REGISTRY_SNAPSHOOT="docker-s.nexus.s3t.co"

                            export REGISTRY_RELEASE="docker-r.nexus.s3t.co"

                            export REGISTRY_USERNAME="$USERNAME1"

                            export REGISTRY_PASSWORD="$PASSWORD1"

                            export DATASOURCE_USERNAME="$USERNAME2"

                            export DATASOURCE_PASSWORD="$PASSWORD2"

                            cd smart-user-api

                            echo "################### ${version}"
                            skaffold deploy --namespace=smart --images=docker-r.nexus.s3t.co/smart/user:${version} --profile=test
                        """
                    }
                }
            }
        }
    }
}
