FROM alpine:3.15

LABEL template.source="https://github.com/k3d-io/k3d/issues/1109#issuecomment-1220374460"

RUN set -ex; \
    apk add --no-cache iptables ip6tables nfs-utils rpcbind openrc; \
    echo 'hosts: files dns' > /etc/nsswitch.conf

RUN rc-update add rpcbind && \
    rc-update add nfs

RUN mkdir -p /run/openrc
RUN touch /run/openrc/softlevel

VOLUME /var/lib/kubelet
VOLUME /var/lib/rancher/k3s
VOLUME /var/lib/cni
VOLUME /var/log

ENV PATH="$PATH:/opt/k3s/bin:/opt/k3s/bin/aux"
ENV CRI_CONFIG_FILE="/var/lib/rancher/k3s/agent/etc/crictl.yaml"

COPY --from=rancher/k3s:v1.25.3-k3s1 /bin /opt/k3s/bin

ADD k3s.nfs.sh /opt/k3s/bin/k3s.nfs.sh

RUN chmod +x /opt/k3s/bin/k3s.nfs.sh
ENTRYPOINT ["/opt/k3s/bin/k3s.nfs.sh"]
CMD ["agent"]
