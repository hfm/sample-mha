FROM debian:9-slim

RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates devscripts debhelper fakeroot perl libmodule-install-perl build-essential

RUN curl -L https://github.com/yoshinorim/mha4mysql-node/archive/v0.58.tar.gz | tar xz -C /usr/local/src

WORKDIR /usr/local/src/mha4mysql-node-0.58/debian

RUN debuild -uc -us

CMD ["cp", "/usr/local/src/mha4mysql-node_0.58-0_all.deb", "/tmp"]
