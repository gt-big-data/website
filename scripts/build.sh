set -e

docker load -i /tmp/workspace/webserver.tar

if [ "$CIRCLE_BRANCH" == "master" ]
then
    export IMAGE_TAG="latest"
else
    export IMAGE_TAG=$CIRCLE_BRANCH
fi

docker tag webserver us.gcr.io/${GOOGLE_PROJECT_ID}/${CIRCLE_PROJECT_REPONAME}:$IMAGE_TAG .