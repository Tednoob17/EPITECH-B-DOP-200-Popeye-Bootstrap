
## B2 - Introduction to DevOps
####  B-DOP-200 


###  Popeye - Bootstrap 

*Eat some spinaches and become a true Docker sailor*


![devopscircle](./.img/gg.png)

### Installation


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

```bash
docker images|awk '{print $1}' |grep '^[a-z]' |wc -l 
```

> Output 
> 
```bash
28
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
> 
```bash
CONTAINER ID   IMAGE      COMMAND                  CREATED         STATUS         PORTS      NAMES
45a677be5d98   postgres   "docker-entrypoint.s…"   8 seconds ago   Up 2 seconds   5432/tcp   kind_fermi
```

5-Is your previous PostgreSQL container still running? Fine, stop it.

```bash
docker stop -t=2 45a677be5d98
```


**Here 45a677be5d98 is postgres container ID**

> Output 

```bash
45a677be5d98
```

6-Even if your container is stopped, it still exists on your system. Remove it.
Yes he is present

```bash
docker rm postgres 
```

7-Bad news! The developper told you that their application is only compatible with PostgreSQL 9.4.
Anyway, run a container with this specific version.

```bash
docker run postgres:9.4 
```

> Info:
> 
   When running a container with an image that is not present on your machine, Docker
will search for it and pull it automatically.

8- You want to list tables, but you cannot connect to this PostgreSQL instance from your host. It seems
like the needed port is not exposed on your machine. How to fix that?

```bash
docker run --name postgres-app -p 5432:5432  postgres:9.4
```




9- In the official PostgreSQL image, the default username/password/database are: postgres / postgres
/ postgres . This is uncreative, but above all unsecure! Find how to change PostgreSQL’s password (when
executing docker run ).

```bash
docker run --name postgre-app -e POSTGRES_PASSWORD=kukuxklan -d postgres:9.4 
```


10 - At the moment, data is not persistant and vanish from hard drive when its associated container is
removed. Be kind to your data and offer them a place to stay on your hard drive.

```bash
docker run --name postegre-app -e POSTGRES_PASSWORD=kukuxklan -v ./data:/var/lib/postgresql/data -d postgressql
```

**Here i precise that i create data direction where database information will stocked**


11- Can you find out which day it is in the container? Execute the command date into a running Post-
greSQL container.

```bash
docker exec -it a0675f8c7c7665f85fd64af5dd8870149f41aed282e8b57ac77f6f80d07f29c3 bash                                                                                
root@a0675f8c7c76:/# date
Wed Jun 28 17:46:27 UTC 2023
```



12- Because you absolutely love reading lines of information written on your screen, find how to display
the logs of your container. (Bonus point if you find how to display them in real time.)

```bash
docker logs a0675f8c7c7665f85fd64af5dd8870149f41aed282e8b57ac77f6f80d07f29c3

```

**In real time**

```bash
docker logs -f  a0675f8c7c7665f85fd64af5dd8870149f41aed282e8b57ac77f6f80d07f29c3

```


## STEP 1 – TIME TO CRAFT


In the previous section, you used an official (prebuilt) Docker image.
It is now time for you to do a real sailor job: creating your own image!
A very simple Node.js application is given to you on the intranet, and your task is now to make an image
out of it.
To do so, you are going to use what is called a Dockerfile. This is a recipe, consisting of one or several in-
structions, that Docker follows to create a custom image. Such operations can include copying files from
the host to the container, running commands, etc.



### 🧑‍🏫 Info
**To be clearer, the construction of an image with a Dockerfile is simply the launch of a base container, the execution of operations in it, and the save of the state of the container at the end,which then allows to launch it multiple times without needing to redo all the previous operations to set up the environment.**


### Instruction

Write a file named Dockerfile at the root of your repository which respects the following specifications: 

- Based on the official debian:buster-slim image. 
- Installs Node.js and its associated package management tool with apt-get . 
- Copies the source code of the application into the image. 
- Installs the application’s dependencies with Node.js’ package management tool. 
- Exposes port 3000. 
- Sets the command (not the entrypoint, beware) to start the application so that the application is run
when running a container based on the image

### 🧑‍🏫 Info

**The above instructions can be executed with one Dockerfile instruction each.**


### 🧑‍🏫 Info

When you have finished, you can build your new image with an easy command: docker build !
You should now be able to run a container with your freshly built image, and have the application launched
automatically (do not not forget to set up a port, so you can access it from your host).

**For debugging, you can run your container with Bash** :
```
docker run -it <my-image> /bin/bash
```
**or execute a command inside a running container with**:
```
docker exec -it <my-image> /bin/bash
```

**Dockerfile** 

```
FROM debian:buster-slim
RUN apt-get update \
    apt-get install curl, wget, nodejs, npm
    
RUN npm install express
ADD App/* .

```

**Building** 

```bash
docker build -t epitech_js .
```
**Running** 

```bash
docker run -it -d -p 3000:80 epitech_js 
```



## STEP 2 – TIME TO CRAFT THE CRAFTER

As you might have seen, proper docker run commands are often quite long.
Docker’s associated tool, Docker Compose, allows to describe a set of containers with the different properties
you want to give them in just a single YAML file. It is very useful as it simplifies a lot the management of the lifecycle of Docker containers’ architectures.
Write a file named docker-compose.yml at the root of your repository which respects the following specifications: 

- Uses the Docker Compose’s syntax version 3. 
- Has a hello-world service which:
   - builds its image by using the previous step’s Dockerfile;
   - forwards container’s port 3000 to host’s port 8080.
- Has a db service which:
   - uses the official PostgreSQL image version 15.2 Alpine;
   - forwards container’s port 5432 to the same host’s port;
   - sets the superuser’s password to popeye using an environment variable or an environment variables file.






### 👨‍🔧 Info 

**If using an environment variables file, you must explicitely specify it in the docker-compose.yml file.**



When you have finished, take a deep breath, and prepare to launch a very simple command that will ignite
for good in yourself the flame of DevOps passion: docker compose up .
Congratulations! You now have a full infrastructure of a Node.js app (with its dependencies) and a database
up and running just with one command, which can be run and work on any OS. Jij bent heel getalenteerd!
You are now ready to sail and to tackle the project! Good luck! (And do not forget to eat your spinaches.)





































































