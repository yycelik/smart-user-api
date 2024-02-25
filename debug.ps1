# Set environment variables
$env:MVN_RREGISTRY_GROUP = "https://nexus.s3t.co/repository/maven-public/"
$env:MVN_RREGISTRY_SNAPSHOOT = "https://nexus.s3t.co/repository/maven-snapshots/"
$env:MVN_REGISTRY_RELEASE = "https://nexus.s3t.co/repository/maven-releases/"

$env:DOCKER_REGISTRY_GROUP = "docker-g.nexus.s3t.co"
$env:DOCKER_REGISTRY_PROXY = "docker-p.nexus.s3t.co"
$env:DOCKER_REGISTRY_SNAPSHOOT = "docker-s.nexus.s3t.co"
$env:DOCKER_REGISTRY_RELEASE = "docker-r.nexus.s3t.co"
$env:MVN_REGISTRY_GROUP = "https://nexus.s3t.co/repository/maven-public/"
$env:REGISTRY_USERNAME = "xxxx"
$env:REGISTRY_PASSWORD = "xxxx"
$env:DATASOURCE_URL = "postgresql.s3t.co:5432"
$env:DATASOURCE_USERNAME = "xxxx"
$env:DATASOURCE_PASSWORD = "xxxx"
$env:CERTIFICATE_PASSWORD = "xxxx"

$Env:KUBECONFIG="$Env:KUBECONFIG;$HOME\.kube\config"

# Run Maven command
mvn install -DskipTests #--batch-mode
if (-not $?) {
    exit 1 
}

# login docker
docker login $env:DOCKER_REGISTRY_SNAPSHOOT -u $env:REGISTRY_USERNAME -p $env:REGISTRY_PASSWORD
if (-not $?) {
    exit 1
}

# build skaffold command
skaffold build #--no-prune=false --cache-artifacts=false
if (-not $?) {
    exit 1
}

# debug application
skaffold debug --no-prune=false --cache-artifacts=false --namespace=smart-dev
