#!/usr/bin/env bash

__get_ip() {
  LOCALIP="127.0.0.1"
  if command -v "ifconfig" > /dev/null; then
    if ip addr show en0 > /dev/null 2>&1; then
      LOCALIP=$(ip addr show en0 | grep -o -e "inet \([^ |\/]*\)" | awk '{ print $2 }')
    elif ip addr show wlp4s0 > /dev/null 2>&1; then
      LOCALIP=$(ip addr show wlp4s0 | grep -o -e "inet \([^ |\/]*\)" | awk '{ print $2 }')
    else
      ONENINETWO="$(ip addr | grep -o -e 'inet 192\.168\.[0-9]\+\.[0-9]\+' | sed -e 's/inet //')"
      if [ "$ONENINETWO" != "" ]; then
        LOCALIP="$ONENINETWO"
      fi
    fi
  fi
  echo "$LOCALIP"
}

LOCALIP="$(__get_ip)"

### docker client aliases

d_a() {
  # delete all running containers
  #shellcheck disable=SC2046
  docker rm -f $(docker ps -q) 2>&1 /dev/null;
}

d_l() {
  # follows the logs of the last container
  docker logs -f "$(docker ps -q | tail -n1)"
}

d_l_watch() {
  #shellcheck disable=SC2016
  watch 'docker logs $(docker ps -q | tail -n1)'
}

d_p() {
  docker ps "${@}"
}

d_c() {
  docker rm -f "$(docker ps -aq)" 2> /dev/null
  docker rm -v "$(docker ps --filter status=exited -q 2>/dev/null)" 2>/dev/null
  docker rmi "$(docker images --filter dangling=true -q 2>/dev/null)" 2>/dev/null
  echo "cleaned"
}

# simple wrapping method that follows a containers logs
_docker_logwrap() {
  docker logs -f "$($1)"
}
_docker_relieson(){ # taken from: https://github.com/jfrazelle/dotfiles/blob/master/.dockerfunc
  local containers=( "$@" )

  for container in "${containers[@]}"; do
      state=$(docker inspect --format "{{.State.Running}}" "$container" 2>/dev/null)

    if [[ "$state" == "false" ]] || [[ "$state" == "" ]]; then
      echo "$container is not running, starting it for you."
  container="d_${container}"
        $container
    fi
  done
}
# specifically for GUI containers on OSX
_require_socat() {
  cmd=$(lsof -nP -i4TCP:6000 | tail -n1 | awk '{ print $1 }')
  if [ "$cmd" != "socat" ]; then
    echo "running socat in background"
    socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\""$DISPLAY"\" &
  else
    echo "socat already running"
  fi
}

### container aliases
# Usage: d_vim ~/path/to/file (just make sure this is mounted, obvs)
d_vim() {
  vimargs=""
  if [ "${1}" != "" ]; then
      vimargs="$(cd "$(dirname "$1")" || exit; pwd)/$(basename "$1")"
  fi
  docker run --rm \
    -v /private/etc/passwd:/etc/passwd:ro \
    -v /private/etc/group:/etc/group:ro \
    -v "${HOME}:${HOME}" \
    -e "PATH=${PATH}" \
    -e "GOPATH=${GOPATH}" \
    -w "${HOME}" \
    -u "$(id -u)" \
    -ti pemcconnell/vimothy:0.1 vim "$vimargs"
}

d_openstack() {
  if [ ! -f ./creds.sh ]; then
    echo "./creds.sh not found"
  else
    if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
    docker run \
        --rm \
        -v "$(pwd)/creds.sh:/creds.sh" \
        -ti pemcconnell/docker-openstack:latest
  fi
}

d_cid() {
  d_registry "$@"
  d_mesosphere "$@"
  d_gitlab "$@"
  d_jenkins "$@"
}

d_registry() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -d \
    -p 5000:5000 \
    --restart=always \
    --name registry \
    registry:2
}

d_jenkins() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 8080:8080 \
    -p 40000:40000 \
    -u 0 \
    -w /root \
    --add-host localhost:127.0.0.1 \
    -v "$HOME/v/jenkins_home:/var/jenkins_home" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$HOME/v/jenkins_user:/root" \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "${HOME}/.netrc:/root/.netrc" \
    --name jenkins \
    -d \
      "${JENKINS_IMAGE:-jenkins/jenkins:lts}"
}

d_mesosphere() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  # zookeeper
  docker run -d \
    --restart always \
    -p 2181:2181 \
    -p 2888:2888 \
    -p 3888:3888 \
    --name zookeeper \
    netflixoss/exhibitor:1.5.2 1>/dev/null

  # master
  docker run -d \
    --restart always \
    -p 5050:5050 \
    --link zookeeper:zk \
    -e MESOS_PORT=5050 \
    -e MESOS_ZK="zk://zk:2181/mesos" \
    -e MESOS_QUORUM=1 \
    -e MESOS_REGISTRY=in_memory \
    -e MESOS_LOG_DIR=/var/log/mesos \
    -e MESOS_WORK_DIR=/var/lib/mesos \
    --name mesos-master \
    mesosphere/mesos-master:0.28.0-2.0.16.ubuntu1404 1>/dev/null

  # slave
  docker run -d \
    --restart always \
    --link zookeeper:zk \
    --link mesos-master:master \
    -p 5051:5051 \
    -e MESOS_SWITCH_USER=0 \
    -e MESOS_CONTAINERIZERS=docker,mesos \
    -e MESOS_PORT=5051 \
    -e MESOS_HOSTNAME="${LOCALIP}" \
    -e MESOS_MASTER=zk://zk:2181/mesos \
    -e MESOS_LOG_DIR=/var/log/mesos \
    -v /sys/fs/cgroup:/sys/fs/cgroup \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "${HOME}/bin/docker/docker-Li386:/usr/bin/docker" \
    --name mesos-slave \
    mesosphere/mesos-slave:0.28.0-2.0.16.ubuntu1404

  # marathon
  docker run \
    -d \
    --restart always \
    -p 8787:8080 \
    --link zookeeper:zk \
    mesosphere/marathon:latest \
    --master zk://zk:2181/mesos --zk zk://zk:2181/marathon 1>/dev/null
}

d_jmeter() {
  # slave
  docker run \
    -P \
    --name jmeterslave1 \
    -v "${HOME}/v/jmeter/docker_mnt/":/jmeter_log \
    -d \
    cirit/jmeter:slave -j /jmeter_log/slave1.log

  # master
  docker run \
    --name jmetermaster \
    -v "${HOME}/v/jmeter/docker_mnt/":/jmeter_log \
    --link jmeterslave1 \
    -P \
    -d \
    cirit/jmeter:master -s -R jmeterslave1 -j /jmeter_log/master.log -l /jmeter_log/result.jtl -X
}

d_elk() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run -d \
    -p 5601:5601 \
    -p 9200:9200 \
    -p 5044:5044 \
    -p 5000:5000 \
    --name elk \
    sebp/elk
}

d_rabbitmq() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run -d \
    -e RABBITMQ_DEFAULT_USER=root \
    -e RABBITMQ_DEFAULT_PASS=pass \
    -p 5672:5672 \
    --name rabbit \
    rabbitmq:3-management
}

d_elasticsearch() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run -d \
    -e ES_JAVA_OPTS="-Xms1g -Xmx1g" \
    -p 9200:9200 \
    -p 9300:9300 \
    -v "$HOME/v/elasticsearch:/usr/share/elasticsearch/data" \
    elasticsearch:5.0.0 -E bootstrap.ignore_system_bootstrap_checks=true
}

d_nexus() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    --add-host gitlab:"${LOCALIP}" \
    --add-host jenkins:"${LOCALIP}" \
    -p 8081:8081 \
    -v "$HOME/v/nexus:/nexus-data" \
    --name nexus \
    -d \
    sonatype/nexus3:latest
}

d_gitlab() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    --add-host jenkins:"${LOCALIP}" \
    --add-host nexus:"${LOCALIP}" \
    -p 80:80 \
    -p 443:443 \
    -p 22:22 \
    -v "$HOME/v/gitlab/config:/etc/gitlab" \
    -v "$HOME/v/gitlab/logs:/var/log/gitlab" \
    -v "$HOME/v/gitlab/data:/var/opt/gitlab" \
    -e GITLAB_OMNIBUS_CONFIG="external_url 'http://gitlab'" \
    --name gitlab \
    -d \
    gitlab/gitlab-ce:latest
}

d_sentry() {
  docker run -d --name sentry-redis redis
  docker run -d --name sentry-postgres -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=sentry postgres
  docker run --rm sentry config generate-secret-key
  docker run -it --rm -e SENTRY_SECRET_KEY='publicongithub' --link sentry-postgres:postgres --link sentry-redis:redis sentry upgrade
  docker run -d -p 8080:9000 --name my-sentry -e SENTRY_SECRET_KEY='publicongithub' --link sentry-redis:redis --link sentry-postgres:postgres sentry
}

d_spark() {
  docker run \
    -p 8088:8088 \
    -p 8042:8042 \
    -it \
    -h sandbox \
    sequenceiq/spark:1.6.0 bash
}

d_cassandra() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 7000:7000 \
    -p 7001:7001 \
    -p 7199:7199 \
    -p 9042:9042 \
    -p 9160:9160 \
    --name cassandra \
    -d \
    cassandra:3
}

d_cqlsh() {
  _docker_relieson "cassandra"
  docker exec -ti cassandra cqlsh
}

d_postgres() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 5432:5432 \
    -e POSTGRES_USER=root \
    -e POSTGRES_PASSWORD=pass \
    --name postgres \
    -d \
    postgres:9.6
}

d_mysql() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 3306:3306 \
    -e MYSQL_USER=root \
    -e MYSQL_ROOT_PASSWORD=pass \
    -v "$HOME/v/mysql:/var/lib/mysql" \
    --name mysql \
    -d \
    mysql:5.7
}

d_mongo() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 27017:27017 \
    -v "$HOME/v/mongodb:/data/db" \
    --name mongodb \
    -d \
    mongo:3.3.8;
}

d_mongouser() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker exec \
-ti \
    mongodb \
    mongo admin --eval "db.createUser({user: 'root', pwd: 'pass', roles:[{role:'root',db:'admin'}]});";
}

d_nginx() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 80:80 \
    --name nginx \
    -d \
    nginx:latest
}

d_http() {
  docker run \
    --rm \
    -ti \
    clue/httpie:latest "$@"
}

d_gerrit() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 8080:8080 \
    -p 29418:29418 \
    -d \
    openfrontier/gerrit
}

d_neo4j() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 7474:7474 \
    -p 7687:7687 \
    -v "$HOME/v/neo4j/data:/data" \
    -d \
    neo4j:3.0
}

d_arrangodb() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -e ARANGO_RANDOM_ROOT_PASSWORD=1 \
    -p 8529:8529 \
    -d \
    arangodb/arangodb
}

d_prometheus() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 9090:9090 \
    -v "$HOME/v/prometheus:/prometheus" \
    -d \
    prom/prometheus:master \
      --config.file=/etc/prometheus/prometheus.yml \
      --storage.tsdb.path=/prometheus \
      --web.console.libraries=/usr/share/prometheus/console_libraries \
      --web.console.templates=/usr/share/prometheus/consoles \
      --web.enable-lifecycle
}

d_vamp() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$(command -v docker):/bin/docker" \
    -v "/sys/fs/cgroup:/sys/fs/cgroup" \
    -e "DOCKER_HOST_IP=192.168.65.2" \
    -p 8080:8080 -p 5050:5050 \
    -p 9090:9090 -p 8989:8989 \
    -p 4400:4400 -p 9200:9200 \
    -p 5601:5601 -p 2181:2181 \
    -d \
    magneticio/vamp-docker:0.9.5
}

d_rundeck() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -p 4440:4440 \
    -e EXTERNAL_SERVER_URL=http://localhost:4440 \
    -d \
    jordan/rundeck:latest
}

d_jupyter() {
  notebookroot="/home/jovyan/work/"
  vol=""
  if [ -f "$1" ]; then
    vol=" -v $(cd "$(dirname "$1")" || exit; pwd)/$(basename "$1"):${notebookroot}$(basename "$1")"
  elif [ -d "$1" ]; then
    vol=" -v $(cd "$(dirname "$1")" || exit; pwd)/:${notebookroot}$(dirname "$1")/"
  fi
  #shellcheck disable=SC2086
  docker run -d -p 8888:8888 $vol \
    jupyter/minimal-notebook sh -c "mkdir -p $notebookroot && start-notebook.sh \
      --NotebookApp.token= \
      --NotebookApp.notebook_dir=$notebookroot"

  sleep 1
  if command -v open; then
    open http://localhost:8888
  else
    echo "open http://localhost:8888"
  fi
}

d_jupytergo() {
  notebookroot="/home/gopher/work/"
  vol=""
  if [ -f "$1" ]; then
    vol=" -v $(cd "$(dirname "$1")" || exit; pwd)/$(basename "$1"):${notebookroot}$(basename "$1")"
  elif [ -d "$1" ]; then
    vol=" -v $(cd "$(dirname "$1")" || exit; pwd)/:${notebookroot}$(dirname "$1")/"
  fi
  #shellcheck disable=SC2086
  docker run -d -p 8888:8888 $vol \
    yunabe/lgo sh -c "mkdir -p $notebookroot && jupyter notebook --ip=0.0.0.0 \
    --NotebookApp.token= \
    --NotebookApp.notebook_dir=$notebookroot"

  sleep 1
  open http://localhost:8888
}

d_nikto() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    --rm \
    -ti \
    pemcconnell/docker-nikto2:alpine
}

d_arachni() {
  _docker_relieson "postgres"
  sleep 1
  if docker exec -ti postgres sh -c "psql -lqt | cut -d \\| -f 1 | grep -qw arachni_production" > /dev/null 2>&1 -ne 0; then
    echo "database doesn't exist. creating"
    docker run \
      --rm \
      --link postgres \
      -e POSTGRES_PASSWORD=pass -e POSTGRES_USERNAME=root -e POSTGRES_DATABASE=arachni_production \
      -ti \
      treadie/arachni sh -c "/opt/arachni/bin/arachni_web_task db:setup"
  else
    echo "default creds: admin@admin.admin / administrator"
    docker run \
      --rm \
      --link postgres \
      -p 9292:9292 \
      -e POSTGRES_PASSWORD=pass -e POSTGRES_USERNAME=root -e POSTGRES_DATABASE=arachni_production \
      -ti \
      treadie/arachni
  fi
}

d_ettercap() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  _require_socat
  docker run \
    --rm \
    -e "DISPLAY=$LOCALIP:0" \
    -ti \
    pemcconnell/ettercap-graphical:latest
}

d_grafana() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -d \
    -v "$HOME/v/grafana:/usr/share/grafana" \
    -e "GF_SERVER_ROOT_URL=http://localhost:3000/" \
    -e "GF_SECURITY_ADMIN_PASSWORD=secret" \
    -p 3000:3000 \
    --name=grafana \
    grafana/grafana
}

d_sonarqube() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker run \
    -d \
    -v "$HOME/v/sonarqube:/opt/sonarqube/" \
    -p 9000:9000 \
    --name=sonarqube \
    sonarqube
}

d_concourse() {
  if [ "${1}" = "l" ]; then _docker_logwrap "${FUNCNAME[0]}"; return; fi
  docker network create concourse-net
  docker run --name concourse-db \
    --net=concourse-net \
    -h concourse-postgres \
    -p 5432:5432 \
    -e POSTGRES_USER=admin \
    -e POSTGRES_PASSWORD=password \
    -e POSTGRES_DB=atc \
    -d postgres
  docker run  --name concourse \
    -h concourse \
    -p 8080:8080 \
    -d \
    -v /var/run/docker.sock:/var/run/docker.sock \
    --privileged \
    --net=concourse-net \
    concourse/concourse quickstart \
    --add-local-user=admin:password \
    --main-team-local-user=admin \
    --external-url=http://localhost:8080 \
    --postgres-user=admin \
    --postgres-password=password \
    --postgres-host=concourse-db \
    --worker-garden-dns-server 8.8.8.8
}

_init_pulsedaemon() {
  if ! pgrep -x "pulseaudio" > /dev/null; then
    pulseaudio --load=module-native-protocol-tcp --exit-idle-time=-1 --daemon
  fi
}

d_player() {
  _init_pulsedaemon
  docker run --rm \
  -e PULSE_SERVER=docker.for.mac.localhost \
  -e "http_proxy=$HTTP_PROXY" \
  -e "https_proxy=$HTTPS_PROXY" \
  -v ~/.config/pulse:/home/pulseaudio/.config/pulse \
  -it \
  --name player \
  pemcconnell/mpsyt:0.1 "$@"
}

d_tizonia() {
  docker run --rm \
    -v ~/.config/tizonia:/home/tizonia/.config/tizonia \
    -v ~/.config/pulse/cookie:/home/tizonia/.config/pulse/cookie \
    -v "${XDG_RUNTIME_DIR}/pulse:${XDG_RUNTIME_DIR}/pulse" \
    -e "PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
    -u "$(id -u)" \
    -ti \
    --name tizonia_mac \
    pemcconnell/tizonia:latest "$@"
}

d_tizonia_mac() {
  _init_pulsedaemon
  docker run --rm \
    -e PULSE_SERVER=docker.for.mac.localhost \
    -e "http_proxy=$HTTP_PROXY" \
    -e "https_proxy=$HTTPS_PROXY" \
    -v ~/.config/pulse:/home/tizonia/.config/pulse \
    -v ~/.config/tizonia:/home/tizonia/.config/tizonia \
    -ti \
    --name tizonia \
    pemcconnell/tizonia:latest "$@"
}

d_rev() {
  local vol
  vol="${VOL:-$(pwd)}"
  docker run --rm \
    --cap-add SYS_PTRACE \
    --security-opt seccomp=unconfined \
    -v "$vol:/src" \
    -w /src \
    -ti \
    pemcconnell/binutils:0.1
}

d_wetty() {
  docker run --rm \
    --name term \
    -e WETTY_USER=term \
    -e WETTY_HASH='' \
    -p 3000:3000 \
    -dt freeflyer/wetty
}

d_bats() {
  docker run --rm \
    --name bats \
    -v "$(pwd):/src" \
    -w /src \
    -ti \
    bats/bats:v1.1.0 "$@"
}

d_shellcheck() {
  docker run --rm \
    --name shellcheck \
    -v "$(pwd):/src" \
    -w /src \
    -ti \
    pemcconnell/shellcheck:bash-4.4.19 "$@"
}

d_vscode() {
  docker run \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=Europe/London \
    -p 8443:8443 \
    -e SSH_AUTH_SOCK=$SSH_AUTH_SOCK \
    -v "$(dirname $SSH_AUTH_SOCK)" \
    -v /tmp/vscode-config/:/config \
    -v "$(pwd):/config/workspace" \
    -v "${HOME}/.gitconfig:/config/.gitconfig:ro" \
    -v "${HOME}/.ssh:/config/.ssh:ro" \
    --restart unless-stopped \
    -ti \
    linuxserver/code-server
}

d_redpanda() {
  docker run -d --pull=always --name=redpanda-1 --rm \
    -p 8081:8081 \
    -p 8082:8082 \
    -p 9092:9092 \
    -p 9644:9644 \
    -p 28082:28082 \
    -p 29092:29092 \
    docker.redpanda.com/vectorized/redpanda:latest \
    redpanda start \
    --overprovisioned \
    --smp 1  \
    --memory 1G \
    --reserve-memory 0M \
    --node-id 0 \
    --check=false \
    --node-id '0' \
    --kafka-addr "PLAINTEXT://0.0.0.0:29092,OUTSIDE://0.0.0.0:9092" \
    --advertise-kafka-addr "PLAINTEXT://${LOCALIP}:29092,OUTSIDE://localhost:9092" \
    --pandaproxy-addr "PLAINTEXT://0.0.0.0:28082,OUTSIDE://0.0.0.0:8082" \
    --advertise-pandaproxy-addr "PLAINTEXT://${LOCALIP}:28082,OUTSIDE://localhost:8082"
}
