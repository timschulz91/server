# Setup with Alpine as host
## Getting started
- Walk through `setup-alpine`.

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
