set -e

if [ "$CIRCLE_BRANCH" == "master" ]
then
    export IMAGE_TAG="latest"
else
    export IMAGE_TAG=$CIRCLE_BRANCH
fi

docker push us.gcr.io/${GOOGLE_PROJECT_ID}/${CIRCLE_PROJECT_REPONAME}:$IMAGE_TAG