#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_arch_docker() {
    sudo pacman -S docker --noconfirm
}

install_debian_docker() {
    sudo apt install -y docker.io
}

if command_exists pacman; then
    install_arch_docker
elif command_exists apt; then
    install_debian_docker
else
    echo "Unsupported distribution"
    exit 1
fi

systemctl start docker
docker pull postgres
docker run -d --name mydb --network=host -e POSTGRES_PASSWORD="$1" postgres
sleep 2
docker exec -it mydb psql -U postgres
