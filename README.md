# Developer Experience
This project outlines how a repository would look like from the developer's perspective.

## `.devcontainer`: Docker Development Container
The `.devcontainer` contains VS Code settings and a Dockerfile describing an image that will be used as a developer's container that they can attach VS Code to develop in. The main advantage here is that the container will have the necessary development tools and VS Code extensions built-in. Some extensions will leverage settings in the `.vscode` folder.
