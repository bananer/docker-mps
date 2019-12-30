FROM openjdk:11

LABEL maintainer="mail@philipfrank.de"

ARG mps_version=2019.3
ARG mps_release=2019.3
ARG jbr_version=11_0_4
ARG jbr_build=b520.11

RUN apt-get clean && apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends ant genisoimage

RUN curl -Lso /tmp/mps.zip https://download.jetbrains.com/mps/$mps_version/MPS-$mps_release.zip
RUN unzip -q /tmp/mps.zip -d /tmp
RUN mv "/tmp/MPS $mps_version" /mps

RUN mkdir /jre
RUN mkdir /jre/win
RUN curl -Lso /tmp/jbr-win.tar.gz https://bintray.com/jetbrains/intellij-jbr/download_file?file_path=jbr-$jbr_version-windows-x64-$jbr_build.tar.gz
RUN tar -C /jre/win -xf /tmp/jbr-win.tar.gz

RUN mkdir /jre/osx
RUN curl -Lso /tmp/jbr-osx.tar.gz https://bintray.com/jetbrains/intellij-jbr/download_file?file_path=jbr-$jbr_version-osx-x64-$jbr_build.tar.gz
RUN tar -C /jre/osx -xf /tmp/jbr-osx.tar.gz

RUN chmod -R a+r /jre

RUN groupadd -r mps && useradd --no-log-init -r -g mps mps
USER mps:mps
WORKDIR /home/mps
