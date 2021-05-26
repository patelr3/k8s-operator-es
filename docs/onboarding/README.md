# Development Container Setup
You are able to leverage a VS Code development container that will have all the necessary tools and extensions downloaded for you! Feel free to use the instructions below to set this environment up. If you would like to make changes to the development image, use the instructions below the setup here. Note that there is a step "2.b." that you can use in replacement of step 2, but step 2 is advised and preferred.

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
6. [Optional] Open the code workspace in `memcached-operator/workspace.code-workspace`.

## 2.b. Use VS Code Development Containers via Remote Docker Host [Not Recommended]
Using this approach causes certain issues and hasn't been solved by the Remote-Extensions community with a straightforward solution just yet. See [this issue](https://github.com/microsoft/vscode-remote-release/issues/2994) for more details. **BUT** there is a workaround if you would like to use this approach. The main difference here is that you will run the docker development container on a remote machine rather than your local one. The approach below follows the steps [here](https://code.visualstudio.com/docs/remote/containers-advanced#_developing-inside-a-container-on-a-remote-docker-host).

1. Decide [which approach](https://code.visualstudio.com/docs/remote/containers#_sharing-git-credentials-with-your-container) you will use for git credentials. If you are using ssh, make sure to follow the correct steps start the [ssh-agent](https://code.visualstudio.com/docs/remote/containers#_using-ssh-keys) and add your ssh key. Do this on the remote machine.
2. Clone the repository on the remote machine AND the local machine.
3. Tell the VS Code docker extension to use your remote machine's docker host instead by adding a VS Code setting. See [here](https://code.visualstudio.com/docs/remote/containers-advanced#_a-basic-remote-example).
```
"docker.host":"ssh://your-remote-user@your-remote-machine-fqdn-or-ip-here"

```
4. Make the necessary changes to the `k8s-operator-es/.devcontainer/.devcontainer.json` file. DO NOT check in these changes. If you want to be safe, add the `.devcontainer` path to your `k8s-operator-es/.git/info/exclude` file.
  1. Add the workspace mount. For `workspaceMount`, use the absolute path on the remote machine to the cloned git repository i.e. `/home/user/git-repos/k8s-operator-es`.
```
{
"workspaceFolder": "/workspace",
"workspaceMount": "source=/absolute/path/on/remote/machine/to/repo,target=/workspace,type=bind,consistency=cached"
}
```
5. Run the **Remote-Containers: Reopen Folder in Container** command from the Command Palette (F1) or **Remote-Containers: Rebuild Container**. You might need to select the folder on the local machine with the git repository cloned. 
6. Wait for container to build.
7. You should be ready to go!

## Development Container Changes
If you would like to make changes to the development container, first briefly go through [VS Code's docs](https://code.visualstudio.com/docs/remote/create-dev-container#_path-to-creating-a-dev-container) about dev container basics.

All the development image contents are defined in the repo's `.devcontainer` folder. There are two main files here.
- `devcontainer.json`: This defines VS Code settings for the development image, including which image or Dockerfile to use to build the development image. You can add VS Code extensions and other settings here.
- `Dockerfile`: This defines the image to use for the development image. Common tools are installed here such as `go`, `operatorsdk`, etc.

As part of the Dockerfile, there are three scripts that are used to facilitate building the docker image. You can update these scripts too if you'd like. They are located in `.devcontainer/scripts`.
- `common-debian.sh`: Installs common tools into the image via `apt-get`.
- `copy-kube-config.sh`: Copy's and syncs the user's local `.kube/config` with the container's.
- `go-debian.sh`: Installs Go tooling at the appropriate paths.
