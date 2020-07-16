# Docker
```bash
# Bulid docker images
$ docker-compose build

# Run docker container
$ rm -f tmp/pid/server.pid && docker-compose up

# Stop and remove containers, networks, images, and volumes.
$ docker-compose down

# Log onto SSH for a container.
$ docker exec -it ${container} /bin/bash

# Run Specs
# P.S. Live Browsing and screen recording are not working with docker yet.
$ docker-compose run web rspec spec
```

Alternatively, you can add the most common commands to your alias.
```shell
# .zshrc or .bashrc
# Docker
alias dcu="rm -f tmp/pid/server.pid && docker-compose up"
alias dcb="docker-compose build"
alias dcd="docker-compose down"
alias dcr="docker-compose run"
alias dit="docker exec -it"