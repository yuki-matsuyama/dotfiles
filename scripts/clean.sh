set -ex
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
docker network rm $(docker network ls -q)
docker volume rm $(docker volume ls -q)

