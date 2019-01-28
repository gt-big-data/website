set -e

if grep -Fq $CIRCLE_PROJECT_REPONAME src/index.html
then
    echo "index.html seems configured correctly"
    exit 0
else
    echo "Couldn't find $CIRCLE_PROJECT_REPONAME in index.html"
    exit 1
fi