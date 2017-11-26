# Setup with Alpine as host
## Getting started
- Walk through `setup-alpine`.

- Set up SSH
  - Temporarily allow root SSH login by setting `PermitRootLogin yes` in
  `/etc/ssh/sshd_config`
  - Restart SSH:
  ```
  service ssh restart
  ```
  - From client, send SSH key to Alpine host:
  ```
  ssh-copy-id root@host # ssh-copy-id -i ~/.ssh/mykey root@host
                          # for a specific key
  ```
  - Disallow root password login by changing `PermitRootLogin yes` to
  `PermitRootLogin prohibit-password`
  - Connect to Alpin using SSH

- Install bash:
```
apk add --no-cache bash bash-completion bash-doc
```
To also make Bash the default shell, change `root:x:0:0:root:/root:/bin/ash` to
`root:x:0:0:root:/root:/bin/bash` in `/etc/passwd`.

- Install git:
```
apk add git --no-cache
```

- Clone the basic server config into a `configs` folder:
```
mkdir configs
cd configs
git clone https://github.com/timschulz91/server.git
```

- Set up Docker
```
cd host_configs/alpine
sh docker_setup.sh  # no bash in alpine
```

- Set up MergerFS
  - Prepare mountpoints and install MergerFS
  ```
  bash mergerfs_prep.sh
  ```
  - Reboot. (This is necessary to get symlinks to `/dev/disk/by-id`.)
