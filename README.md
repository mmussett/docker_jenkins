# Containerised Jenkins Server

## Setup Steps




1) Login to Ubuntu and sudo to root

```
$ sudo su -
```

2) Install git

```
$ apt install -y git
```

3) Clone the git repository
```
$ git clone https://github.com/mmussett/jenkins.git
```

4) Install Docker & Docker Compose
```
$ cd jenkins
$ ./bootstrap.sh
```

5) Build Jenkins container and start

```
$ ./start.sh
```

## Verification Test

```
$ docker ps -a
docker ps | grep jenkins
72d68ef12fa8        jenkins_master      "/usr/local/bin/jenk…"   3 minutes ago   Up 3 minutes    0.0.0.0:8000->8000/tcp, 0.0.0.0:50000->50000/tcp   puppet_jenkins
```

Jenkins will be running in the container on port 8000 and forwarding on port 8000 rather than the default 8080.

The initial Jenkins administrator password can be found by running:

```
$ docker logs puppet_jenkins 2>&1 | grep -A 2 "password"
```




## Stopping Jenkins


To stop Jenkins container:

```
./stop.sh
```