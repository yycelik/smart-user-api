# Set environment variables
$env:REGISTRY_GROUP = "docker-g.nexus.s3t.co"
$env:REGISTRY_PROXY = "docker-p.nexus.s3t.co"
$env:REGISTRY_SNAPSHOOT = "docker-s.nexus.s3t.co"
$env:REGISTRY_RELEASE = "docker-r.nexus.s3t.co"
$env:REGISTRY_USERNAME = "xxxxx"
$env:REGISTRY_PASSWORD = "xxxxx"
$env:DATASOURCE_URL = "xxxx:xxx"
$env:DATASOURCE_USERNAME = "xxx"
$env:DATASOURCE_PASSWORD = "xxx"
$env:CERTIFICATE_PASSWORD = "xxx"

$Env:KUBECONFIG="$Env:KUBECONFIG;$HOME\.kube\config"

# Run Maven command
mvn install -DskipTests --batch-mode

# build skaffold command
skaffold build

#
skaffold dev --no-prune=false --cache-artifacts=false --namespace=smart-dev


 