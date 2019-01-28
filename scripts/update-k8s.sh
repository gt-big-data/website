set -e

if git diff --name-only HEAD~1 HEAD | grep -q k8s
then
    echo "Detected changes to k8s config, updating..."
    gcloud --quiet container clusters get-credentials ${GOOGLE_PROJECT_ID} --region=${GOOGLE_COMPUTE_REGION}

    kubectl apply -f --recursive=true ./k8s
    kubectl rollout status deployment/${CIRCLE_PROJECT_REPONAME}
else
    echo "No changes detected in k8s config, no update needed."
fi