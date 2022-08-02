#!/usr/bin/env bash

# shellcheck disable=SC1090
. ~/.dockerfunc

samplesize() {
  size="${1:-10}"
  numfmt --to iec --format "%8.4f" $(du -shc */ --block-size=1 | sort -R | head -n$size | awk '{ print $1 }' | jq -s add/length)
}

# custom brightness function for arch linux on 2016 mbp
s_bright(){
  lvl="${1:-$(cat /sys/class/backlight/gmux_backlight/max_brightness)}"
  fchar="$(echo "$lvl" | head -c1)"
  current="$(cat /sys/class/backlight/gmux_backlight/brightness)"
  if [ "$fchar" = "+" ]; then
    lvl="${lvl#?}"
    lvl="$((current + lvl))"
  elif [ "$fchar" = "-" ]; then
    lvl="${lvl#?}"
    lvl="$((current - lvl))"
  fi
  sudo chown "$(whoami)" /sys/class/backlight/gmux_backlight/brightness
  echo "$lvl" > /sys/class/backlight/gmux_backlight/brightness
}

wd() {
  # where are the feckin docs?
  path="${1:-.}"
  find "$path" \( -iname \*.rst -o -iname \*.md \) -exec ls -al "{}" \;
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

cdls()
{
  if [ "$#" = 0 ]; then
    cd ~ && ls -alt
  elif [ -d "$*" ]; then
    cd "$*" && ls -alt
  else
    >&2 echo "$*" directory not found!!!
  fi
}

function validate_terraform() {
  find . -type f -name "*.tf" -exec dirname {} \;|sort -u | while read -r m; do (terraform validate -check-variables=false "$m" && echo "√ $m") || exit 1 ; done
}

function wiremock() {
  if ! [ -f ~/wiremock.jar ]; then
    echo 'wiremock not found!'
    exit 1
  fi
  java -jar ~/wiremock.jar --port 9000 --proxy-all="$1" --record-mappings
}

__wget() {
  : "${DEBUG:=0}"
  local URL=$1
  local tag="Connection: close"
  local mark=0

  if [ -z "${URL}" ]; then
    printf "Usage: %s \"URL\" [e.g.: %s http://www.google.com/]" \
      "${FUNCNAME[0]}" "${FUNCNAME[0]}"
    return 1;
  fi

  read -r proto server path <<<$(echo ${URL//// })
  DOC=/${path// //}
  HOST=${server//:*}
  PORT=${server//*:}
  [[ x"${HOST}" == x"${PORT}" ]] && PORT=80
  [[ $DEBUG -eq 1 ]] && echo "HOST=$HOST"
  [[ $DEBUG -eq 1 ]] && echo "PORT=$PORT"
  [[ $DEBUG -eq 1 ]] && echo "DOC=$DOC"

  exec 3<>/dev/tcp/${HOST}/$PORT
  echo -en "GET ${DOC} HTTP/1.1\r\nHost: ${HOST}\r\n${tag}\r\n\r\n" >&3
  while read line; do
    [[ $mark -eq 1 ]] && echo $line
    if [[ "${line}" =~ ${tag} ]]; then
      mark=1
    fi
  done <&3
  exec 3>&-
}

remove_duplicate_lines() {
  source_file="$1"
  dest_file="$2"
  awk '!visited[$0]++' "$source_file" "$dest_file"
}

scrape_yt() {
  dl="$(youtube-dl --extract-audio --audio-format mp3 "$1")"
  echo "$dl"
  file="$(echo "$dl" | grep -e "^\[ffmpeg\] Destination:" | sed -e "s@^.*: @@")"
  cleanfilename="$(echo "$file" | sed -e "s@-[a-zA-Z0-9]\+\..*\$@@" | sed -e "s@[^a-zA-Z0-9]@-@g" -e "s@[\-]\+@-@g").mp3"
  echo "cleaning up filename to $cleanfilename"
  mv "$file" "$cleanfilename"
}
