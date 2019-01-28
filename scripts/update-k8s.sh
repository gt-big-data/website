if git diff --name-only HEAD~1 HEAD | grep -q k8s.yml
then
    echo "Detected some changes to k8s.yml, updating configuration..."
    apt-get -qqy install gettext-base
    envsubst < ${HOME}/project/k8s.yml > ${HOME}/patched_k8s.yml

    gcloud --quiet container clusters get-credentials ${GOOGLE_PROJECT_ID} --region=${GOOGLE_COMPUTE_REGION}

    kubectl apply -f ${HOME}/patched_k8s.yml
    kubectl rollout status deployment/${CIRCLE_PROJECT_REPONAME}
else
    echo "No changes detected in k8s.yml, no update needed"
fi