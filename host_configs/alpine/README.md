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
  - Uncomment Edge repos in `/etc/apk/repositories`, `apk update`
  - Prepare mountpoints and install MergerFS
  ```
  bash mergerfs_prep.sh
  ```
  - Reboot. (This is necessary to get symlinks to `/dev/disk/by-id`.)
  - Edit `/etc/fstab` by adding indiviual disks and the MergerFS pool
  ```
  # mount non-system disks
  /dev/disk/by-id/ata-VBOX_HARDDISK_...0a-part1	/mnt/parity01   ext4	defaults			0 0
  /dev/disk/by-id/ata-VBOX_HARDDISK_...04-part1	/mnt/parity02   ext4	defaults			0 0
  /dev/disk/by-id/ata-VBOX_HARDDISK_...14-part1	/mnt/disk01     ext4	defaults			0 0
  /dev/disk/by-id/ata-VBOX_HARDDISK_...43-part1	/mnt/disk02     ext4	defaults			0 0
  /dev/disk/by-id/ata-VBOX_HARDDISK_...0c-part1	/mnt/disk03     ext4	defaults			0 0
  /dev/disk/by-id/ata-VBOX_HARDDISK_...86-part1	/mnt/disk04     ext4	defaults			0 0
  /dev/disk/by-id/ata-VBOX_HARDDISK_...61-part1	/mnt/cache01	ext4	defaults			0 0
  # mount mergerfs storage
  /mnt/disk*	/mnt/storage	mergerfs	direct_io,defaults,allow_other,minfreespace=100K,fsname=mergerfs	0 0
  ```
  Since Alpine doesn't come with `lsblk`, it might be useful to find out the
  size of a disk for the purpose of identifying it using `cat /proc/partitions`.
  - For some reson MergerFS mounting inside `fstab` doesn't work. I suspect it
  relies on a service that's only started later, but I can't figure it out.
  As a workaround, run
  ```
  bash mergerfs_startup.sh
  ```
