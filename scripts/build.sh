set -e

docker load -i /tmp/workspace/webserver.tar

if [ "$CIRCLE_BRANCH" == "master" ]
then
    export IMAGE_TAG="latest"
else
    export IMAGE_TAG=$CIRCLE_BRANCH
fi

envsubst

docker tag webserver:latest us.gcr.io/bdc-backend/website:content-restoration .