# k3s-docker

From: https://github.com/k3d-io/k3d/issues/1109#issuecomment-1220374460


## Command used to run docker

docker run --rm -d \
    --name="node-docker-$(date +%s)" \
    --privileged \
    -e K3S_TOKEN=[TOKEN] \
    -e K3S_URL=https://[loadBalanceIP]:6443 \
    -e K3S_NODE_NAME="node-docker-$(date +%s)" \
    marcoaraujo/k3s-nfs-client:v1.25.3-k3s1 \
    agent \
    --snapshotter native

