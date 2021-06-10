# k8s-operator-es
This project is simply a test project to setup a [VS Code development container](https://code.visualstudio.com/docs/remote/create-dev-container) that will ultimately be used to develop a [Kubernetes Operator](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/) using the [OperatorFramework](https://operatorframework.io/).

To use the development container in the context of this repository, follow [these instructions](docs/onboarding/README.md).

## Operators
There are several operators in the repo. They are all based on tutorials or are basic operators to get familiar with K8s operators and the operator framework.

### cronjob-operator
This is based on the [kubebuilder cronjob tutorial](https://book.kubebuilder.io/cronjob-tutorial/cronjob-tutorial.html).

### memcached-operator
This is based on the [operatorframework quickstart tutorial](https://sdk.operatorframework.io/docs/building-operators/golang/quickstart/).
