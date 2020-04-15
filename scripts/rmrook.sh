#!/bin/bash

kubectl -n rook-ceph patch cephclusters.ceph.rook.io rook-ceph -p '{"metadata":{"finalizers": []}}' --type=merge
kubectl delete -f services/rook-cluster.yml
helm del --purge rook-ceph
kubectl -n rook-ceph delete cephcluster rook-ceph
kubectl -n rook-ceph delete storageclass rook-ceph-block
kubectl delete ns rook-ceph-system
kubectl delete ns rook-ceph
ansible k8s-cluster -b -m file -a "path=/var/lib/rook state=absent"
