DOCKER_PROJECT_NAME=$1
SERVER_NAME=$2
LOCALHOST="127.0.0.1"
HOSTS="/etc/hosts"
ENV="docker/.env"
DOCKER_COMPOSE="docker/docker-compose.yml"
WATCHER_SERVER="lib/watcher/server.js"
WATCHER_CLIENT="lib/watcher/client.js"
DEFAULT_DOCKER_PROJECT_NAME="ssl-docker-php"
DEFAULT_SERVER_NAME="DOMAIN_NAME"
GREEN="\e[32m"
EC="\e[0m"

function checkVHostExists {
  if [[ -n $(egrep -lir --include=$HOSTS "$LOCALHOST $SERVER_NAME" $HOSTS) ]]; then
    sudo sed -i '' "/$SERVER_NAME/d" $HOSTS
    printf "✅ Removed existing ${GREEN}%s${EC} from ${GREEN}%s${EC}\n" $SERVER_NAME $HOSTS
  fi
}

function refreshHosts {
  sudo sh -c 'killall -HUP mDNSResponder'
  printf "✅ Hosts refreshed.\n"
}

function appendVHost {
  checkVHostExists

  if [[ -e $HOSTS && -r $HOSTS ]]; then
    printf "%s %s\n" $LOCALHOST $SERVER_NAME | sudo tee -a $HOSTS >/dev/null
    refreshHosts
    printf "✅ %s added to the /etc/hosts successfully\n" $SERVER_NAME
  else
    printf "❌ Cannot rewrite hosts file"
    exit 1
  fi
}

function generateEnvFile {
  echo "SERVER_NAME=$SERVER_NAME" >$ENV
  printf "✅ .env file generated.\n"
}

function replaceDockerName {
  sed -i '' "s/$DEFAULT_DOCKER_PROJECT_NAME/$DOCKER_PROJECT_NAME/" $DOCKER_COMPOSE
  printf "✅ Docker container named.\n"
}

function replaceWatcherServerName {
  sed -i '' "s/$DEFAULT_SERVER_NAME/$SERVER_NAME" $WATCHER_SERVER
  sed -i '' "s/$DEFAULT_SERVER_NAME/$SERVER_NAME" $WATCHER_CLIENT
  printf "✅ Watcher script server name updated.\n"
}

function generateSSLCert {
  cd certs/
  mkcert $SERVER_NAME
  cd ..
  printf "✅ SSL certificate for $SERVER_NAME domain generated.\n"
}

function setupDocker {
  cd docker
  docker compose up -d
  cd ..
  printf "✅ Docker container is running.\n"
}

printf "🥷  ${GREEN}SSL Docker PHP${EC} | Setup script running...\n\n"
appendVHost
generateEnvFile
generateSSLCert
replaceDockerName
replaceWatcherServerName
setupDocker
printf "\n${GREEN}✅ Done. ${EC}Happy coding, Ninja! 👋\n"
