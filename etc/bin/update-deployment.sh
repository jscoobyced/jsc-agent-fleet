#!/bin/bash

kubectl rollout restart deployment jsc-opencode-web -n opencode-ns
kubectl scale deployment jsc-opencode-web -n opencode-ns --replicas=0
kubectl scale deployment jsc-opencode-web -n opencode-ns --replicas=1