# Developer Experience
This project outlines how a repository would look like from the developer's perspective.

## `.devcontainer`: Docker Development Container
The `.devcontainer` contains VS Code settings and a Dockerfile describing an image that will be used as a developer's container that they can attach VS Code to develop in. The main advantage here is that the container will have the necessary development tools and VS Code extensions built-in. Some extensions will leverage settings in the `.vscode` folder.

## Setting Up SSH
### WSL 2.0
1. Follow instructions to [enable ssh-agent](https://code.visualstudio.com/docs/remote/containers#_using-ssh-keys) on startup.
2. Make sure the setting "Terminal-> Integrated: Inherit Env" is on in VS Code in User settings. This is from [these steps](https://code.visualstudio.com/docs/remote/containers-advanced#_adding-environment-variables). You don't need to follow Option 1 as it is already checked in.
