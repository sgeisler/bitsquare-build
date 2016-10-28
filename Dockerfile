FROM maven:3-jdk-8

RUN \
  echo "deb http://ftp.de.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
  apt-get update && \
  apt-get install -y openjfx

RUN \
  wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip && \
  unzip jce_policy-8.zip && \
  cp UnlimitedJCEPolicyJDK8/US_export_policy.jar $JAVA_HOME/jre/lib/security/US_export_policy.jar && \
  cp UnlimitedJCEPolicyJDK8/local_policy.jar $JAVA_HOME/jre/lib/security/local_policy.jar && \
  rm -r UnlimitedJCEPolicyJDK8 && \
  rm jce_policy-8.zip

RUN mkdir -p /local/data

# clone and install bitcoinj
WORKDIR /local/data
RUN git clone -b FixBloomFilters https://github.com/bitsquare/bitcoinj.git
WORKDIR /local/data/bitcoinj
RUN mvn clean install -DskipTests -Dmaven.javadoc.skip=true

