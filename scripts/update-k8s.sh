if git diff --name-only HEAD~1 HEAD | grep -q k8s.yml
then
    echo "Detected some changes to k8s.yml, updating configuration..."
    envsubst < ${HOME}/project/k8s.yml > ${HOME}/patched_k8s.yml
    kubectl apply -f ${HOME}/patched_k8s.yml
    kubectl rollout status deployment/${PROJECT_NAME}
else
    echo "No changes detected in k8s.yml, no update needed"
fi