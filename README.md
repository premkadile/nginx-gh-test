# Description

Build nginx used by Rails projects and push to ECR by CircleCI.

# Notices

- Ngnix assumes Rails project running at port 9292
- Rails code lives in app:/usr/src/app 'app' is the name of Rails project Docker instance

```
IMAGE_REPO_NAME=spireinc/nginx_puma
IMAGE_TAG=sandbox|staging|production
```