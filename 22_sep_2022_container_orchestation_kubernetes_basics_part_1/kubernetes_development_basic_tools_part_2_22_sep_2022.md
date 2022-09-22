## Demo on: Kubernetes Development Basic Tools (ending), 22 Sep 2022 

### VS Code on Linux VM

We start from local machine

1. Run Git Bash terminal

2. Use your ssh connection data to connect to VM.  

`<ssh_connection_data>` can have the form `<login_on_VM>@<IP_address_of_VM>` e.g. `bkarpov@192.168.1.208`, 
or be an alias configured for connection to VM in  `~/.ssh/config`

```
ssh <ssh_connection_data>
```

3. Install `code-server` package. If the VM OS is Manjaro Linux, run the command 

```
yay -S code-server 
```

Otherwise, follow the [instruction](https://github.com/coder/code-server#getting-started)


4. Start running VS Code on VM listening port 8080

```
code-server --bind-addr 0.0.0.0:8080
```

5. On local machine, start the second instance of Git Bash terminal


6. Use your ssh connection data (see Step 2) to connect to VM, with port forwarding 9080 -> 8080.

```
$ ssh -L 9080:127.0.0.1:8080 <ssh_connection_data>
```

7. On local machine, open in browser

```
http://127.0.0.1:9080/
```

Login form will be displayed, with the path to file on VM containing password


8. In the second Git Bash instance connected to VM (Steps 5, 6), see the file

```
cat ~/.config/code-server/config.yaml
```

Copy password to the clipboard


9. On local machine, in browser, paste the password, log in, and you are done


### How to permanently display Kubernetes current context in `zsh` command separator

**Prerequisites:** you should have Manjaro Linux installed on VM and run Alliedium [scripts](https://github.com/Alliedium/awesome-linux-config/tree/master/manjaro#instructions)


10. In the second Git Bash instance connected to VM (Steps 5, 6), open file in editor

```
nano ~/.p10k.zsh
```

By searching `kubectl` pattern

```
Hit <Ctrl+W>
Type 'kubectl'
Hit <Enter>
```

find the line `typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm|kubens|kubectx|oc'`

Comment the line

Save the file and close the editor


11. Run the command to apply changes in current terminal session

```
source ~/.p10k.zsh
```

or, close and re-open the ssh connection to VM

