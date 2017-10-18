#!/bin/bash
TAGS=()
RUN=false
for i in "$@"
do
case ${i} in
   -t=*|--tag=*)
    TAGS+=("${i#*=}")
    shift # past argument=value
    ;;
    -r|--run)
    RUN=true
    shift
    ;;
    *)
            # unknown option
    ;;
esac
done

# default values
TAGS+=("-t automox/logdemon:latest")

# operating system check
DOCKERFILE=docker/ubuntu/Dockerfile

TAGS_STR=$( IFS=$' '; echo "${TAGS[*]}" )

docker stop logdemon && docker rm logdemon
docker build --no-cache $TAGS_STR -f "${DOCKERFILE}" .
if [ "${RUN}" = "true" ]; then
    docker run -d --name logdemon automox/logdemon:latest
fi

