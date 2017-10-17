#!/bin/bash
TAGS=()
RUN=false
for i in "$@"
do
case ${i} in
    -s=*|--operating-system=*)
    OS="${i#*=}"
    shift # past argument=value
    ;;
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

if [ -z "$OS" ]; then
	echo "OS not provided. Using ubuntu..."
	OS="ubuntu"
fi

# operating system check
OS=`echo $OS | tr '[:upper:]' '[:lower:]'`
if [ "$OS" = "ubuntu" ]; then
	DOCKERFILE=docker/ubuntu/Dockerfile
elif [ "$OS" = "alpine" ]; then
	DOCKERFILE=docker/alpine/Dockerfile
fi

TAGS_STR=$( IFS=$' '; echo "${TAGS[*]}" )

docker stop logdemon && docker rm logdemon
docker build --no-cache $TAGS_STR -f "${DOCKERFILE}" .
if [ "${RUN}" = "true" ]; then
    docker run -d --name logdemon automox/logdemon:latest
fi

