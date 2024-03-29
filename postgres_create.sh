pacman -S docker --noconfirm
systemctl start docker
docker pull postgres
docker run -d --name mydb --network=host -e POSTGRES_PASSWORD=password postgres
docker exec -it mydb psql -U postgres
