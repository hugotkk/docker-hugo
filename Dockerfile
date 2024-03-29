# syntax=docker/dockerfile:1
FROM alpine:latest
RUN apk add --no-cache supervisor hugo git
COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord", "-n"]
