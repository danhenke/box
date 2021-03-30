# BOX

1. Signin to 1Password.
```bash
eval $(op signin <account>)
```

2. Setup environment variables.
```bash
eval $(./init_env.sh)
```

3. Initialize the Digital Ocean infrastucture.
```bash
./init_droplet.sh
```

4. Initialize Docker swarm and context.
```bash
./init_docker.sh
```

## Linux

```bash
apt update
apt upgrade -y
apt autoremove -y
ufw reset
ufw allow ssh
ufw allow http
ufw allow https
ufw enable
```

## Traefic

```bash
docker --context=box network create --driver=overlay traefik
docker --context=box stack deploy -c traefik.yml traefik
docker --context=box stack deploy -c whoami.yml whoami
```

https://www.rockyourcode.com/traefik-2-docker-swarm-setup-with-docker-socket-proxy-and-more/

