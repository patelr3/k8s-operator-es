# Setting Up Kubernetes
This guide will suggest several kubernetes distros to use for development purposes. Please note that the kubernetes cluster does not have to be deployed in the same location as your development environment. The only important piece is that the `$HOME/user/.kube/config` points to whichever cluster you would like to target.

## Docker Desktop's Kubernetes (Recommended)
Docker Desktop can deploy a single-node cluster for you that will be quick and easy to use for development purposes. If you'd like to set this up, follow the instructions [here](https://docs.docker.com/desktop/kubernetes/#:~:text=Docker%20Desktop%20includes%20a%20standalone%20Kubernetes%20server%20and,local%20system%2C%20and%20is%20only%20for%20local%20testing.). The basics of those instructions are:
1. Open Docker Desktop
2. Open Settings->Kubernetes
3. Select `Enable Kubernetes`
4. Wait for the Kubernetes service to be ready. You'll see it's symbol go green at the bottom-left side of the Docker Desktop application.

## Kubeadm
You should deploy a kubeadm cluster in Linux. You can follow instructions [here](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/). More detailed instructions and automation scripts will be coming soon.

## Minikube
You can also use [Minikube](https://minikube.sigs.k8s.io/docs/start/) to deploy. It should be noted though that if you are using our `.devcontainer`, it is recommended to use Docker Desktop's Kubernetes cluster on Windows and Mac according to [devcontainer's docs](https://github.com/Microsoft/vscode-dev-containers/tree/main/containers/kubernetes-helm#a-note-on-minkube-or-otherwise-using-a-local-cluster).
