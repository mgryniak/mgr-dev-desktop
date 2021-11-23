# Docker Container based on the Debian 11 + x2go-server
## Description

* xfce4 desktop
  * terminator
  * arc-theme
* x2go-server
* Visual Studio Code
  * ms-vscode-remote.remote-ssh
  * ms-vscode-remote.remote-ssh-edit  
* Chromium Browser

Default user:

```
user: dev
pass: dev
```

## How to use this Docker Container

### Run in the interactive mode 

```
./runit.sh
```

or

```
docker run -it --privileged --rm --name="mgr-dev-desktop" -p 5022:22 mgryniak/mgr-dev-desktop
```

### Run in the background mode 

```
./run.sh
```

or

```
docker run -d --privileged --name="mgr-dev-desktop" -p 5022:22 mgryniak/mgr-dev-desktop
```

## Connect to the x2go remote desktop

Install x2go client: https://wiki.x2go.org/doku.php/doc:installation:x2goclient

Create connection by:
```
Host: 127.0.0.1
Login: dev 
SSH port: 5022
Session type: XFCE

pass: dev
```



