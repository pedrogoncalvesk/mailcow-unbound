FROM alpine:3.6

LABEL maintainer "Pedro Pereira <pedrogoncalvesp.95@gmail.com>"

RUN apk add --update --no-cache \
	curl \
	unbound \
	bash \
	openssl \
	drill \
	&& curl -o /etc/unbound/root.hints https://www.internic.net/domain/named.cache \
	&& chown root:unbound /etc/unbound \
	&& chmod 775 /etc/unbound

EXPOSE 53/udp 53/tcp

COPY docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

COPY unbound.conf /etc/unbound/

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/unbound"]
