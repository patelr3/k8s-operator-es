# Cronjob Operator

This operator was built through the [kubebuilder tutorial](https://book.kubebuilder.io/cronjob-tutorial/cronjob-tutorial.html). This document will describe the different pieces of code and scaffolding introduced by the operator framework. Most of this code is scaffolded by the operator framework from the `operator-sdk init` command.

## Contents
The operator framework creates several important files to make note of. Let's go through some of these files.

- `Makefile`: The makefile will facilitate building and deploying the operator. This can also be used to run a controller locally thats connected to a kubernetes cluster (skipping having to deploy the operator)
- `Dockerfile`: The Dockerfile creates the necessary docker image for the operator. The docker file is split into two stages:
    - Stage 1: Builds the operator using a Go image. Notice that only the `api` and `controllers` folders and `go.mod`, `go.sum`, and `main.go` files are copied into the image.
    - Stage 2: Copies operator binary into a smaller production image.
- `go.mod` and `go.sum`: Files for dependency management in the Go project.
- `PROJECT`: Describes project settings for the operator framework.
- `main.go`: Starting point of the operator code.

## Go Code Structure
This subsection will focus on the different Go files and code that implement the operator.

### kubebuilder markers
There is a concept of [markers](https://book.kubebuilder.io/reference/markers.html) that will automatically generate code in the operator. These are scattered throughout the code and follow the below pattern:
```go
//+kubebuilder:<group>:<subgroup>:<etc>
```

### `main.go`
This file creates the binary/cmd to start the operator. There is a concept of a _manager_ that will register controllers in the operator and will facilitate communicating with the API server in K8s. Most of the manager's setup is implemented in this file.

### `api/v1`
Different K8s types are implemented here. In this operator, there is:

- `cronjob_types.go`: This will describe the cronjob Custom Resource Definition (CRD). Key points here are:
    - Spec: This describes the spec that a user would submit to kubernetes to create this custom resource based on the CRD.
    - Status: This describes the state of the custom resource and cluster state to the world.

- `cronjob_webhook.go`: This will implement the different K8s webhooks we'd like for the cronjob API group. There are two types implemented here:
    - Validating: The validating webhook is a webhook that is not _mutating_. That is, the webhook doesn't need to change the submitted resource at all. It only validates the contents of that resource. So if a user submits an invalid spec, the validating webhook would raise an error when checking the contents of the submitted resource.
    - Defaulting: The defaulting webhook is a webhook that _is mutating_. This webhook will change the submitted resource by inserting default values in the spec of the resource.

- `groupversion_info.go`: This will contain constants and related code for the K8s group version we are implementing.

The rest of the files are extra generated code or test files.

### `controllers`
This contains the actual control loop logic/reconciliation logic of the operator. There can be multiple controllers for an operator. The rule of thumb is usually one control loop per custom resource.

- `cronjob_controller.go`: Contains the reconciliation logic for a cron job. This is the bulk of the logic for an operator.

### `config`

This folder contains various kubernetes manifest files to use for an operator, including sample or test manifests to use during development.

## Conclusion
This covers most of the scaffolding done by the operator framework. The framework allows a developer to focus more so on the logic necessary in their operator rather than how to communicate with the K8s api server and hook everything up correctly.