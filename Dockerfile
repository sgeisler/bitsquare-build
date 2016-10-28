FROM maven:3-jdk-8

RUN \
  echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y openjfx

RUN mkdir -p /local/data

# clone and install bitcoinj
WORKDIR /local/data
RUN git clone -b FixBloomFilters https://github.com/bitsquare/bitcoinj.git
WORKDIR /local/data/bitcoinj
RUN mvn clean install -DskipTests -Dmaven.javadoc.skip=true

