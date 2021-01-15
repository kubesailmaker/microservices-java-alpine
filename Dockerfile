FROM azul/zulu-openjdk-alpine:11.0.9
LABEL base=alpine engine=jvm version=java11 timezone=UTC port=8080 dir=/opt/app user=app

RUN apk update && apk add --no-cache tzdata curl bash gcompat openssl && rm -rf /var/cache/apk/*
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

EXPOSE 8080

RUN mkdir -p /opt/app && ln -s /opt/app /libs && mkdir -p /opt/db-migrations && ln -s /opt/db-migrations /flyway

WORKDIR /opt/app

RUN addgroup -g 1000 -S app && adduser -u 1000 -G app -S app \
&& chown -R app:app /opt/app /libs /opt/db-migrations /flyway

USER app
