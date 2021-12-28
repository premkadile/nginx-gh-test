# Base image:
FROM nginx:1.17.7

# Install dependencies
RUN apt-get update -qq \
  && apt-get --no-install-recommends -y install apache2-utils \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

LABEL "com.datadoghq.ad.check_names"='["nginx"]'
LABEL "com.datadoghq.ad.init_configs"='[{}]'
LABEL "com.datadoghq.ad.instances"='[{"nginx_status_url": "http://%%host%%:%%port%%/nginx_status"}]'

# establish where Nginx should look for files
ENV RAILS_ROOT /usr/src/app

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# create log directory
RUN mkdir log


# Copy Nginx config template
COPY org-nginx.conf /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY spirehealth.com.crt  /etc/pki/tls/certs/
COPY spirehealth.com.key  /etc/pki/tls/certs/

EXPOSE 443

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
