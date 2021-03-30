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
