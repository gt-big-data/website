# gtbigdata.club

[![Build Status](https://img.shields.io/circleci/project/github/gt-big-data/website.svg?logo=circleci&style=for-the-badge)](https://circleci.com/gh/gt-big-data/website)
[![Code Coverage](https://img.shields.io/codecov/c/github/gt-big-data/website/master.svg?logo=codecov&style=for-the-badge)](https://codecov.io/gh/gt-big-data/website)
[![Chat on Slack!](https://img.shields.io/badge/Chat-on%20Slack-4A154B.svg?logo=slack&style=for-the-badge)](bigdataclub.slack.com)

This is where the code for our website lives alongside the .yml files that dictate our Kubernetes infrastructure, and all the glue code required to get our CI/CD pipeline up and running.

## This is a lot of files for a website

To be as buzzword-y as possible, this repo represents a cluster of two (2) Dockerized microservices (this site, and [our internal api](https://github.com/gt-big-data/api)), each with one (1) deployment by default. If you think that sounds like overkill for a club, you're right. If you think that sounds like fun, feel free to hit us up on [Facebook](https://www.facebook.com/gtbigdataclub/) or [Slack](https://bigdataclub.slack.com)

In alphabetical order, here's what's happening in this repo.

* [.circleci/](#.circleci/)
* [k8s/](#k8s/)
* [scripts/](#scripts)
* [src/](#src/)
  * [static/](#src/static/)
  * [templates/](#src/templates/)
* [Dockerfile](#Dockerfile)

### .circleci/

Contains our CircleCI configuration. We use Circle over Travis or other options because it's really painless to work with Google Cloud, which is where we have all our stuff hosted.

### k8s/

Holds the configuration we're using for our website, our internal api, and our ssl certification, as well as how we route our traffic.

### scripts/

In order to reduce clutter in our CircleCI config file, we moved some of our scripting steps into this folder. This allows for a cleaner separation of concerns, where `.circleci/config.yml` contains just the structure of our pipeline, and `scripts/` contains the actual execution of steps.

### src/

This is where the actual source code for our website lives. It's a Python app running Flask as the web framework.

#### src/static/

All of our static files live here -- assets, stylesheets, js files.

#### src/templates

These HTML files are actually Jinja templates that Flask uses to render its final output.

### Dockerfile

We package this app up into a Docker image, which we host on our private GCR registry because it's free and convenient. You can build yourself a copy by cloning this repo and running `docker build .`