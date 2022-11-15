# inception

[![Intro](https://img.shields.io/badge/Cursus-inception-success?style=for-the-badge&logo=42)](https://github.com/mlanca-c/inception)
 
 [![Stars](https://img.shields.io/github/stars/mlanca-c/inception?color=ffff00&label=Stars&logo=Stars&style=?style=flat)](https://github.com/mlanca-c/inception)
 [![Size](https://img.shields.io/github/repo-size/mlanca-c/inception?color=blue&label=Size&logo=Size&style=?style=flat)](https://github.com/mlanca-c/inception)
 [![Activity](https://img.shields.io/github/last-commit/mlanca-c/inception?color=red&label=Last%20Commit&style=flat)](https://github.com/mlanca-c/inception)

The main goal of this project is to build a small infrastructure composed of
different services under specific rules using **Docker**.

It consists of creating a **Docker app** - by building custom **Docker images**
for each service and managing them with the **docker compose** command.

The required services of the **Inception** App are `NGINX`, `MariaDB` and
`WordPress`.

> The purpose of the infrastructure is to have a running `WordPress` site.
> A WordPress site needs to have a database, for that the app uses `MariaDB`
> as the database management system.
> `NGINX` will serve as a reverse proxy server for WordPress requests.

This is how the app is structured:

```
├── Makefile
└── srcs
    ├── docker-compose.yml
    ├── .env
    └── requirements
        ├── mariadb
        │   └── Dockerfile
        ├── nginx
        │   └── Dockerfile
        └── wordpress
            └── Dockerfile
```

In the srcs/ directory there's a **docker-compose.yml** file.
This file defines the **services**, **volumes** and **networks** specifications
of the Docker app.

In srcs/requirements/ all the main services are listed as folders, and inside
each folder there is a **Dockerfile**.
Each Dockerfile defines how a **Docker image** is built.

> In this project all the Docker images are custom build.
> There's no use of any ready-made images from Docker Hub.

This project requires a relative knowledge of Docker.
And an extensive read of the different services' documentation.
Because it not only creates each service's own Docker image, but also configures
how the services connect to each other to create a functional app.
 
# Cloning

 ```
 git clone git@github.com:mlanca-c/inception.git
 cd inception 
 ```
 
# Compiling
 
 ```
 make up
 ```

# Intro

 > [subject](subject.pdf)

# Useful Links

 * [Wiki](https://github.com/mlanca-c/inception/wiki)
