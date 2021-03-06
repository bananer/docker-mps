FROM openjdk:11

LABEL maintainer="philip@nagler.world"

ARG mps_version=2021.1
ARG mps_release=2021.1.1
ARG jbr_version=11_0_11
ARG jbr_build=b1341.57

RUN apt-get clean && apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ant genisoimage wixl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -Lso /tmp/mps.zip https://download.jetbrains.com/mps/$mps_version/MPS-$mps_release.zip \
    && unzip -q /tmp/mps.zip -d /tmp \
    && mv "/tmp/MPS $mps_version" /mps \
    && rm /tmp/mps.zip \
    && chmod -R a+rX /mps

RUN mkdir -p /jre/win \
    && wget -q -O - https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-$jbr_version-windows-x64-$jbr_build.tar.gz \
    | tar xz --directory /jre/win --no-same-owner --no-same-permissions \
    && chmod -R a+rX /jre/win

RUN mkdir -p /jre/osx \
    && wget -q -O - https://cache-redirector.jetbrains.com/intellij-jbr/jbr_jcef-$jbr_version-osx-x64-$jbr_build.tar.gz \
    | tar xz --directory /jre/osx --no-same-owner --no-same-permissions \
    && chmod -R a+rX /jre/osx

RUN groupadd -r mps && useradd --no-log-init -r -g mps mps
USER mps:mps
WORKDIR /home/mps
