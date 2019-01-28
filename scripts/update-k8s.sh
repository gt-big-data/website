if git diff --name-only HEAD~1 HEAD | grep -q k8s
then
    echo "Detected some changes to k8s configuration, updating..."
    gcloud --quiet container clusters get-credentials ${GOOGLE_PROJECT_ID} --region=${GOOGLE_COMPUTE_REGION}

    kubectl apply -Rf ${HOME}/k8s/*.yml
    kubectl rollout status deployment/${CIRCLE_PROJECT_REPONAME}
else
    echo "No changes detected in k8s.yml, no update needed"
fi