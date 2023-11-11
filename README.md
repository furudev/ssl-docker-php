# 🐳 SSL Docker PHP

Quick setup of Docker with Franken PHP and custom SSL domain name for local development.

## 🛠️ Tools

* MacOS
* [Docker](https://www.docker.com)
* [Franken PHP](https://github.com/dunglas/frankenphp)
* [mkcert](https://github.com/FiloSottile/mkcert)

## 🐾 Steps

1. Clone this repository.
2. Enter a proper name of your docker container in `docker/docker-compose.yml`.
3. Rename `docker/.env.example` to `docker/.env`.
4. Go to `/certs` directory and create a certificate for your local development domain:

> `mkcert your.domain.name`

5. Enter your domain name from step 4 inside `SERVER_NAME` field in `docker/.env`.

6. Add your domain name at the end of your `/etc/hosts` file (**sudo required**)

```
127.0.0.1 your.domain.name
```

7. Refresh DNS addresses (**sudo required**):

> `sudo killall -HUP mDNSResponder`

8. Compose your container

> `cd docker && docker compose up -d`

9. ✅ Done. Happy coding! 🥷

## 💡 Feature ideas
- [ ] simplify steps with bash script
