FROM openjdk:11

LABEL maintainer="philip@nagler.world"

ARG mps_version=2021.3
ARG mps_release=2021.3
ARG jbr_version=11_0_11
ARG jbr_build=b1341.57

# find link on https://teamcity.jetbrains.com/project/MPS?mode=builds#all-projects
# under "Get Resources" for matching MPS version
ARG jbr_build_url=https://teamcity.jetbrains.com/repository/download/MPS_20213_Distribution_GetResources/3784556:id/openJDK

RUN apt-get clean && apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends ant genisoimage wixl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -Lso /tmp/mps.zip https://download.jetbrains.com/mps/$mps_version/MPS-$mps_release.zip \
    && unzip -q /tmp/mps.zip -d /tmp \
    && mv "/tmp/MPS $mps_version" /mps \
    && rm /tmp/mps.zip \
    && chmod -R a+rX /mps

RUN mkdir -p /jre/win \
    && wget -q -O - $jbr_build_url/jbr-windows-x64.tar.gz \
    | tar xz --directory /jre/win --no-same-owner --no-same-permissions \
    && chmod -R a+rX /jre/win

RUN mkdir -p /jre/osx \
    && wget -q -O - $jbr_build_url/jbr-osx-x64.tar.gz \
    | tar xz --directory /jre/osx --no-same-owner --no-same-permissions \
    && chmod -R a+rX /jre/osx

RUN groupadd -r mps && useradd --no-log-init -r -g mps mps
USER mps:mps
WORKDIR /home/mps
