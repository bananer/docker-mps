FROM openjdk:11

LABEL maintainer="mail@philipfrank.de"

ARG mps_version=2020.1
ARG mps_release=2020.1.1
ARG jbr_version=11_0_6
ARG jbr_build=b765.40

RUN apt-get clean && apt-get update && apt-get upgrade -y

RUN apt-get install -y --no-install-recommends ant genisoimage wixl

RUN curl -Lso /tmp/mps.zip https://download.jetbrains.com/mps/$mps_version/MPS-$mps_release.zip \
    && unzip -q /tmp/mps.zip -d /tmp \
    && RUN mv "/tmp/MPS $mps_version" /mps \
    && rm /tmp/mps.zip \
    && chmod -R a+rX /mps

RUN mkdir -p /jre/win \
    && set -o pipefail \
    && wget -q -O - https://bintray.com/jetbrains/intellij-jbr/download_file?file_path=jbr-$jbr_version-windows-x64-$jbr_build.tar.gz \
    | tar xz -C /jre/win \
    && chmod -R a+rX /jre/win

RUN mkdir -p /jre/osx \
    && set -o pipefail \
    && wget -q -O - https://bintray.com/jetbrains/intellij-jbr/download_file?file_path=jbr-$jbr_version-osx-x64-$jbr_build.tar.gz \
    | tar xz -C /jre/osx \
    && chmod -R a+rX /jre/osx

RUN groupadd -r mps && useradd --no-log-init -r -g mps mps
USER mps:mps
WORKDIR /home/mps
