# Dockerized Flask sample app
```bash
docker build -t flask-sample:1.0 .
docker run -d --name flask-app -p 8080:5000 flask-sample:1.0
curl http://localhost:8080/
curl http://localhost:8080/api/info
docker logs flask-app
docker history flask-sample:1.0
docker stop flask-app && docker rm flask-app
```
