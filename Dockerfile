FROM openjdk:8

LABEL maintainer="mail@philipfrank.de"

ARG mps_version=2018.3
ARG mps_minor_version=4
ARG jbrx_version=8u202
ARG jbrx_build=b1483.31

RUN apt-get clean && apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends ant genisoimage

RUN curl -Lso /tmp/mps.zip https://download.jetbrains.com/mps/$mps_version/MPS-$mps_version.$mps_minor_version.zip
RUN unzip -q /tmp/mps.zip -d /tmp
RUN mv "/tmp/MPS $mps_version" /mps

RUN mkdir /jre
RUN mkdir /jre/win
RUN curl -Lso /tmp/jbrx-win.tar.gz https://bintray.com/jetbrains/intellij-jdk/download_file?file_path=jbrx-$jbrx_version-windows-x64-$jbrx_build.tar.gz
RUN tar -C /jre/win -xf /tmp/jbrx-win.tar.gz

RUN mkdir /jre/osx
RUN curl -Lso /tmp/jbrx-osx.tar.gz https://bintray.com/jetbrains/intellij-jdk/download_file?file_path=jbrx-$jbrx_version-osx-x64-$jbrx_build.tar.gz
RUN tar -C /jre/osx -xf /tmp/jbrx-osx.tar.gz

RUN chmod -R a+r /jre

RUN groupadd -r mps && useradd --no-log-init -r -g mps mps
USER mps:mps
WORKDIR /home/mps
