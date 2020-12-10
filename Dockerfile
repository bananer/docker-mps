FROM openjdk:11

LABEL maintainer="mail@philipfrank.de"

ARG mps_version=2020.2
ARG mps_release=2020.2.2
ARG jbr_version=11_0_9
ARG jbr_build=b944.49

RUN apt-get clean && apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends ant genisoimage wixl

RUN curl -Lso /tmp/mps.zip https://download.jetbrains.com/mps/$mps_version/MPS-$mps_release.zip \
    && unzip -q /tmp/mps.zip -d /tmp \
    && mv "/tmp/MPS $mps_version" /mps \
    && rm /tmp/mps.zip \
    && chmod -R a+rX /mps

RUN mkdir -p /jre/win \
    && wget -q -O - https://bintray.com/jetbrains/intellij-jbr/download_file?file_path=jbr-$jbr_version-windows-x64-$jbr_build.tar.gz \
    | tar xz --directory /jre/win --no-same-owner --no-same-permissions \
    && chmod -R a+rX /jre/win

RUN mkdir -p /jre/osx \
    && wget -q -O - https://bintray.com/jetbrains/intellij-jbr/download_file?file_path=jbr-$jbr_version-osx-x64-$jbr_build.tar.gz \
    | tar xz --directory /jre/osx --no-same-owner --no-same-permissions \
    && chmod -R a+rX /jre/osx

RUN groupadd -r mps && useradd --no-log-init -r -g mps mps
USER mps:mps
WORKDIR /home/mps
