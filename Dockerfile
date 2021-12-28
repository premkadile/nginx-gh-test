# Base image:
FROM nginx:1.17.7


COPY spirehealth.com.crt  /etc/pki/tls/certs/
COPY spirehealth.com.key  /etc/pki/tls/certs/

EXPOSE 443

# Use the "exec" form of CMD so Nginx shuts down gracefully on SIGTERM (i.e. `docker stop`)
CMD [ "nginx", "-g", "daemon off;" ]
