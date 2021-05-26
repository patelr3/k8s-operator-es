# Development Container Setup
You are able to leverage a VS Code development container that will have all the necessary tools and extensions downloaded for you! Feel free to use the instructions below to set this environment up. Note that there are only particular environments where this works well for now. Particularly starting a development container through ssh is a little tricky at this time.

## 1. Download the tools
1. Download [Visual Studio Code](https://code.visualstudio.com/Download). This will be the IDE that we will use.
2. Download [Docker Desktop](https://www.docker.com/products/docker-desktop). 
3. Open VS Code and download the [Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker#:~:text=Docker%20for%20Visual%20Studio%20Code%20The%20Docker%20extension,Visual%20Studio%20Code%20documentation%20site%20to%20get%20started.) and the [Remote Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers).
4. Setup Kubernetes. You can use [this guide](./Kubernetes.md) as a reference or starting point. It's recommended to simply use Docker Desktop's Kubernetes cluster as the quickest approach - particularly for Windows or Mac.

## 2. Use VS Code Development Containers
It should be noted that this section assumes you are cloning the repository locally and not through SSH (WSL 2.0 works for this section). Using development containers will not work through the ssh extension in a simple/straightforward way.
1. Decide [which approach](https://code.visualstudio.com/docs/remote/containers#_sharing-git-credentials-with-your-container) you will use for git credentials. If you are using ssh, make sure to follow the correct steps start the [ssh-agent](https://code.visualstudio.com/docs/remote/containers#_using-ssh-keys) and add your ssh key.
2. Clone the repository.
3. Set up your git identity i.e. `git config user.email "user@example.com"` and `git config user.name "First Last"`
4. Follow the pop-up to use Remote - Containers or run Ctrl+Shift+P, and select "Remote-Containers: Open in Container".
5. Wait for the Development Container to build, and then you should be ready to develop!
