### Setup docker on Debian 8.1

Install notes: https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-repository

Docker CLI: https://docs.docker.com/engine/reference/run/

Script that installs docker-ce: `setup_docker_debian.sh`

### Build&Run OPCX docker container

Pre: `OPCoinX.conf MUST be available under link OPCX_CONF_URL as pointed out in the Dockerfile`

Build container: `sudo docker build --tag opcx:1.0.0 .`

Run container: `docker run -d --name opcx.cont opcx:1.0.0`

See if it is up: `docker ps -a`

Shell in the container: `docker exec -it opcx.cont /bin/bash`

Test RPC: `opcx-cli -rpcuser=opcx -rpcpassword=<from config file> help`

Stop container: `docker stop opcx.cont`
