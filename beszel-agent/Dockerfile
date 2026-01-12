ARG BUILD_FROM
FROM $BUILD_FROM

# Install glibc compatibility for Alpine (required for dynamically linked beszel-agent v0.18.1+)
RUN apk --no-cache add ca-certificates wget && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.35-r1/glibc-2.35-r1.apk && \
    apk add --no-cache --force-overwrite glibc-2.35-r1.apk && \
    rm glibc-2.35-r1.apk

COPY config.yaml /
RUN grep version < config.yaml | grep -oe '[0-9\.]*' > VERSION && rm config.yaml

RUN curl -s "https://api.github.com/repos/henrygd/beszel/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' > BESZEL_AGENT_VERSION

COPY run.sh /
RUN chmod a+x /run.sh

WORKDIR /
RUN curl -sL "https://github.com/henrygd/beszel/releases/latest/download/beszel-agent_$(uname -s)_$(uname -m | sed 's/x86_64/amd64/' | sed 's/armv7l/arm/' | sed 's/aarch64/arm64/').tar.gz" | tar -xz -O beszel-agent | tee ./beszel-agent >/dev/null && chmod +x beszel-agent

CMD [ "/run.sh" ]
