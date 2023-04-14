

## B2 - Introduction to DevOps
####  B-DOP-200 








###  Popeye - Bootstrap 

*Eat some spinaches and become a true Docker sailor*


![devopscircle](./.img/gg.png)

### Popeye - Bootstrap

#### STEP 0 – HELLO DOCKER!


> A LITTLE QUIZ TO START WITH

* Q: 
**Before starting to use Docker, it is important to gain some knowledge and to either acquire or clarify impor-tant points. Try to answer those questions with your friends**


- What is Docker?
- What is the difference between Virtual Machines and Docker containers?
- How much are 2 Docker containers separated when running on the same machine?
- What is the difference between a Docker container and a Docker image?
- In what way will spinach helps you to master DevOps?

* Answers:
 
- Docker is a software platform that allows you to build, test, and deploy applications quickly
- VMs have the host OS and guest OS inside each VM. A guest OS can be any OS, like Linux or Windows, irrespective of the host OS. In contrast, Docker containers host on a single physical server with a host OS, which shares among them. Sharing the host OS between containers makes them light and increases the boot time.
- ?
- The key difference between a Docker image vs a container is that a Docker image is a template that defines how a container will be realized. A Docker container is a runtime instance of a Docker image.
- I don't know



#### HANDS ON THE RUDDER


1. Find the official PostgreSQL image and import it on your machine.
> cli
```bash
docker search postgresql --filter=is-official=true
```
> Output 

```bash
NAME       DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
postgres   The PostgreSQL object-relational database sy…   12148     [OK]       
```

For installation 
```bash
docker pull postgres
```

> Tips for resolve all Question 1 in one commande
```bash
image=$(docker search PostgreSQL --filter=is-official=true|awk '{print $1}'|tail -1) && docker pull $image
```
> Download output
```bash
➜  test git:(main) ✗ docker pull postgres
Using default tag: latest
latest: Pulling from library/postgres
f1f26f570256: Downloading [================================>                  ]  20.44MB/31.41MB
f1f26f570256: Pull complete 
1c04f8741265: Pull complete 
dffc353b86eb: Pull complete 
18c4a9e6c414: Pull complete 
81f47e7b3852: Pull complete 
5e26c947960d: Pull complete 
a2c3dc85e8c3: Pull complete 
17df73636f01: Pull complete 
713535cdf17c: Pull complete 
52278a39eea2: Pull complete 
4ded87da67f6: Pull complete 
05fae4678312: Pull complete 
56b4f4aeea2d: Pull complete 
Digest: sha256:5a90725b3751c2c7ac311c9384dfc1a8f6e41823e341fb1dceed96a11677303a
Status: Downloaded newer image for postgres:latest
docker.io/library/postgres:latest

```
2- Show how many images you have on your machine.
> cli 

```bash
docker images|awk '{print $1}' |grep '^[a-z]' |wc -l
```

> Output
```bash
31
```

3- Run a PostgreSQL container.
```bash
docker run -it postgres /bin/bash
```

4- Show containers running on your machine. Do you see the container ID of PostgreSQL?
```bash
	docker ps
```
> Output
```bash
➜  ~ git:(main) ✗ docker ps 
CONTAINER ID   IMAGE      COMMAND                  CREATED         STATUS         PORTS      NAMES
45a677be5d98   postgres   "docker-entrypoint.s…"   8 seconds ago   Up 2 seconds   5432/tcp   kind_fermi
```

5-Is your previous PostgreSQL container still running? Fine, stop it.

```bash
	docker stop -t=2 45a677be5d98
```
	**Here 45a677be5d98 is postgres container ID **

> Output 

```bash
	45a677be5d98
```

6-Even if your container is stopped, it still exists on your system. Remove it.


```bash


```























































































































































