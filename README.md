# 🐳 SSL Docker PHP

Quick setup of Docker with Franken PHP and custom SSL domain name for local development.

## 🛠️ Tools

* MacOS
* [Docker](https://www.docker.com)
* [Franken PHP](https://github.com/dunglas/frankenphp)
* [mkcert](https://github.com/FiloSottile/mkcert)
* [ws](https://www.npmjs.com/package/ws)
* [Chokidar](https://www.npmjs.com/package/chokidar)
* [PostCSS](https://postcss.org/)
* [CSSNano](https://cssnano.co/)


## 🐾 Steps

1. Clone this repository.
2. Setup file permissions to execute `setup.sh` script.

```
chmod +x setup.sh
```

3. Run `setup.sh` with 2 arguments (this step will ask for sudo access to perform )

```
./setup.sh $DOCKER_PROJECT_NAME $SERVER_NAME
```

- `$DOCKER_PROJECT_NAME` is unique name of your docker compose project name.
- `$SERVER_NAME` is your unique SSL domain name.

Example

```
./setup.sh php-setup dockerphpsetup.ninja
```

4. ✅ Done. Happy coding! 🥷

## 💡 Feature ideas

- [x] simplify steps with bash script
- [x] watch for changes in `*.php` files
- [x] watch for changes in `*.css` files and output minified css code with PostCSS
- [ ] add a script to automatically load `client.js` watcher script
- [ ] add an error handling to the `setup.sh` script
