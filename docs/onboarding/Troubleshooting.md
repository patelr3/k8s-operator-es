# Troubleshooting
Here are some common troubleshooting steps to take when working in your development environment on this project. If none of the below help, the best thing to do is look at the logs from the development container failure.

## `git push` Permission Denied
Double check that your ssh-agent on your local machine is running and has your ssh identity. You can check which ssh identities are added with `ssh-add -L`. If it is missing for some reason, run `ssh-add path-to-id_rsa` to add it back.

## Docker container fails to mount volume
The docker container will mount your local repository files to the running development container. If you cannot mount the volume, most likely there is already a running devcontainer. Go to the "Remote Explorer` Extensions, use the drop-down to navigate to "Containers", and remove or connect to your existing devcontainer if it already exists.

## Generic Devcontainer issues
A catch-all troubleshooting step is to rebuild the development container. You can do this using `Ctrl+Shift+P` and running `Remote-Containers: Rebuild Container`.

