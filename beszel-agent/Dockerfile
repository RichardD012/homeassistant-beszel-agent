ARG BUILD_FROM
FROM $BUILD_FROM

# Install glibc compatibility for Alpine (required for dynamically linked beszel-agent v0.18.1+)
# Using gcompat which provides glibc compatibility on Alpine's musl
RUN apk --no-cache add gcompat libstdc++

COPY config.yaml /
RUN grep version < config.yaml | grep -oe '[0-9\.]*' > VERSION && rm config.yaml

RUN curl -s "https://api.github.com/repos/henrygd/beszel/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' > BESZEL_AGENT_VERSION

COPY run.sh /
RUN chmod a+x /run.sh

WORKDIR /
RUN curl -sL "https://github.com/henrygd/beszel/releases/latest/download/beszel-agent_$(uname -s)_$(uname -m | sed 's/x86_64/amd64/' | sed 's/armv7l/arm/' | sed 's/aarch64/arm64/').tar.gz" | tar -xz -O beszel-agent | tee ./beszel-agent >/dev/null && chmod +x beszel-agent

CMD [ "/run.sh" ]
