## Kubernetes Development Basic Tools (ending), Kubernetes cluster contexts 22 Sep 2022 ##

### Prerequisites ###

- The following commands were executed on VM with [Manjaro Linux distribution](https://manjaro.org/download/) (however, they might be performed on another Linux distribution, but the command might differ, e.g. another package manager etc.)
- Docker installed (see [Lesson 5 prerequisites](../05_docker_basic_commands_postgres_23-aug-2022/README.md))
- k3d, kubectl installed as per steps of [Lesson 11](../11_k8s_dev_tools_kubectl_krew_vscode_15-sep-2022/README.md)

### code-server on Linux VM ###

On local machine:

1. Run Git Bash terminal.

2. Use SSH connection data to connect to VM.  

`<ssh_connection_data>` can have the form `<login_on_VM>@<IP_address_of_VM>` e.g. `bkarpov@192.168.1.208`, 
or be an alias configured for connection to VM in  `~/.ssh/config`

```
ssh <ssh_connection_data>
```

3. Install `code-server` package. If the VM OS is Manjaro Linux, run the command:

```
yay -S code-server 
```

Otherwise, follow the [instruction](https://github.com/coder/code-server#getting-started).


4. Start running _code-server_ on VM listening port 8080:

```
code-server --bind-addr 0.0.0.0:8080
```

5. On local machine, start the second instance of Git Bash terminal.

6. Use your SSH connection data (see Step 2) to connect to VM, with port forwarding 9080 -> 8080:

```
$ ssh -L 9080:127.0.0.1:8080 <ssh_connection_data>
```

7. On local machine, open in browser `http://127.0.0.1:9080/`.

Login form will be displayed, with the path to file on VM containing password

8. In the second Git Bash instance connected to VM (Steps 5, 6), check the file:

```
cat ~/.config/code-server/config.yaml
```

Copy password to the clipboard.

9. On local machine, in browser, paste the password, log in, and you are done.


### How to permanently display Kubernetes current context in `zsh` command separator

10. Run Alliedium [scripts](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro#instructions).

11. In the second Git Bash instance connected to VM (Steps 5, 6) comment the line `typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc'`:

```
sed -i "s/typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc'/#typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc'"
```

11. Run the command to apply changes in current terminal session:

```
source ~/.p10k.zsh
```

or, close and re-open the SSH connection to VM.


### References ###

1. [Lens | The Kubernetes IDE](https://k8slens.dev/)
2. [Lens LICENSE](https://github.com/lensapp/lens/blob/master/LICENSE)
3. [Is it time to migrate from Lens to OpenLens to manage your Kubernetes clusters?](https://blog.devgenius.io/is-it-time-to-migrate-from-lens-to-openlens-75496e5758d8)
4. [OpenLens project on GitHub](https://github.com/MuhammedKalkan/OpenLens)
5. [OpenLens Releases](https://github.com/MuhammedKalkan/OpenLens/releases)
6. [Обзор k9s — продвинутого терминального интерфейса для Kubernetes](https://habr.com/ru/company/flant/blog/524196/)
7. [k9s | Kubernetes CLI To Manage Your Clusters In Style!](https://k9scli.io/)
8. [API: use cases for kubectl attach?](https://github.com/kubernetes/kubernetes/issues/23335)
9. [Kubectl attach vs kubectl exec?](https://stackoverflow.com/a/50031131)
10. [Attach to existing containers](https://kubernetes.io/blog/2015/10/some-things-you-didnt-know-about-kubectl_28/#attach-to-existing-containers)
11. [Docker | Start containers automatically](https://docs.docker.com/config/containers/start-containers-automatically/)
12. [Restart option for new version (3.0) · Issue #317 · k3d-io/k3d](https://github.com/k3d-io/k3d/issues/317)