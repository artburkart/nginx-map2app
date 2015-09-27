# Quick and dirty proxy to app

Sometimes I like to use docker-compose to start up an nginx container to proxy
requests to another container. This is my quick and dirty solution.

I don't use this in production; it's mostly there to help me develop Dockerfiles
for other applications.

I've included an example `docker-compose.yml` file in the [GitHub repo](https://github.com/artburkart/nginx-map2app/blob/master/docker-compose.yml).

```console
docker-compose up -d
```

## If you're not familiar with docker-compose, you can achieve the same thing:

```console
docker run -d -p 80 --name hello-world tutum/hello-world
docker run -d -p 9090:80 --link hello-world:hello-world -e APP_PROXY=http://hello-world:80 nginx-map2app
```
