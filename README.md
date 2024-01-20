# UPDATE

`ssl-docker-php` transformed into [Ashiba.ninja](https://github.com/furudev/ashiba.ninja).

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

3. Make sure you have `node.js` installed if you want to use file watcher to have auto refreshing functionality in the browser.

4. Install node packages `npm i` or `yarn i` or `pnpm i`.

5. Run `setup.sh` with 2 arguments (ℹ️ _this step will ask you for a sudo access to modify `/etc/hosts` file and refresh DNS_)

```
./setup.sh $DOCKER_PROJECT_NAME $SERVER_NAME
```

- `$DOCKER_PROJECT_NAME` is unique name of your docker compose project name.
- `$SERVER_NAME` is your unique SSL domain name.

Example

```
./setup.sh php-setup dockerphpsetup.ninja
```

6. ✅ Done. Open your favourite browser and type domain name that you passed to the `setup.sh` script. Happy coding! 🥷

7. If you want to enable a file watcher run watcher script

```
npm run watch
```

and include a script tag with `client.js` file to your main `.php` file (_this step will be removed in the next update in favour of autoloader script._). Refresh current browser window and edit your `stylesheet.css` file and see changes live like a true ninja! 🥷

## 💡 Feature ideas

- [x] simplify steps with bash script
- [x] watch for changes in `*.php` files
- [x] watch for changes in `*.css` files and output minified css code with PostCSS
- [ ] replace PostCSS and CSSNano with Lightning CSS
- [ ] add a script to automatically load `client.js` watcher script
- [ ] watch for changes in `*.js` files
- [ ] add an error handling to the `setup.sh` script
