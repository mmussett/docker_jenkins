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

5) Install Jenkins

```
./start.sh
```


To stop Jenkins run:

```
./stop.sh
```