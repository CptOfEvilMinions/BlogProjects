FROM alpine:latest

# Install squid
RUN apk -U add ca-certificates libressl && apk add squid

#USER squid
#CMD ["/usr/sbin/squid", "-f", "/etc/squid/squid.conf"]

RUN mkdir -p /var/cache/squid \
    && /usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 100MB

VOLUME [/var/cache/squid/ /etc/squid/]
EXPOSE 3128/tcp 3129/tcp
CMD ["squid", "-NYCd 1"]




# FROM alpine:latest

# # Update and install squid
# RUN apk update && apk add squid curl

# RUN /bin/chown -R squid:squid /var/cache/squid
# RUN /bin/chown -R squid:squid /var/log/squid
# RUN /usr/sbin/squid -z
# RUN sleep 5

# CMD ["squid", "-NYCd 1"]
