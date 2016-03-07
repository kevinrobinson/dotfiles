[[ -r ~/.bashrc ]] && . ~/.bashrc

# docker
function containers {
  docker ps -a | awk '{print $1}' | grep -v CONTAINER
}

function dimplode {
  containers | xargs docker kill
  containers | xargs docker rm
}

# lists all images more than a month or week old, and removes them from the cache
function docker_clean_image {
  docker rmi $(docker images --no-trunc  | egrep ' (weeks|months) ago' | tr -s ' ' | cut -d' ' -f3)
}

# see http://blog.yohanliyanage.com/2015/05/docker-clean-up-after-yourself/
function docker_clean_volumes {
  docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
}

# requires sudo
function flush_dns {
  dscacheutil -flushcache
  killall -HUP mDNSResponder
}