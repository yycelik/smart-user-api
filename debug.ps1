# Set environment variables
$env:MVN_RREGISTRY_GROUP = "https://nexus.s3t.co/repository/maven-public/"
$env:MVN_RREGISTRY_SNAPSHOOT = "https://nexus.s3t.co/repository/maven-snapshots/"
$env:MVN_REGISTRY_RELEASE = "https://nexus.s3t.co/repository/maven-releases/"

$env:DOCKER_REGISTRY_GROUP = "docker-g.nexus.s3t.co"
$env:DOCKER_REGISTRY_PROXY = "docker-p.nexus.s3t.co"
$env:DOCKER_REGISTRY_SNAPSHOOT = "docker-s.nexus.s3t.co"
$env:DOCKER_REGISTRY_RELEASE = "docker-r.nexus.s3t.co"
$env:MVN_REGISTRY_GROUP = "https://nexus.s3t.co/repository/maven-public/"
$env:REGISTRY_USERNAME = "xxxxx"
$env:REGISTRY_PASSWORD = "xxxxx"
$env:DATASOURCE_URL = "s3t.co:3306"
$env:DATASOURCE_USERNAME = "xxxxx"
$env:DATASOURCE_PASSWORD = "xxxxx"
$env:CERTIFICATE_PASSWORD = "xxxxx"

$Env:KUBECONFIG="$Env:KUBECONFIG;$HOME\.kube\config"

# Run Maven command
mvn install -DskipTests #--batch-mode

# login docker
docker login $env:DOCKER_REGISTRY_SNAPSHOOT

# build skaffold command
skaffold build #--no-prune=false --cache-artifacts=false

# debug application
skaffold dev --no-prune=false --cache-artifacts=false --namespace=smart-dev
