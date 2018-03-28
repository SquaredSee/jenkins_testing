# use the official PostgreSQL image as a base
FROM postgres:9.4.17-alpine


# OpenJDK Dockerfile from https://github.com/docker-library/openjdk/blob/2598f7123fce9ea870e67f8f9df745b2b49866c0/8-jdk/alpine/Dockerfile

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
        echo '#!/bin/sh'; \
        echo 'set -e'; \
        echo; \
        echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
    } > /usr/local/bin/docker-java-home \
    && chmod +x /usr/local/bin/docker-java-home

ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin
ENV JAVA_VERSION 8u151
ENV JAVA_ALPINE_VERSION 8.151.12-r0

RUN set -x \
    && apk add --no-cache \
        openjdk8="$JAVA_ALPINE_VERSION" \
    && [ "$JAVA_HOME" = "$(docker-java-home)" ]


# Jira Dockerfile from https://github.com/cptactionhank/docker-atlassian-jira-software/blob/master/Dockerfile

# Jira environment variables
ENV JIRA_HOME /var/atlassian/jira
ENV JIRA_INSTALL /opt/atlassian/jira
ENV JIRA_VERSION 7.8.1

# add jira group and user (may be unneeded?)
RUN groupadd -r jira && useradd -r -g jira jira

# set shell parameters
# -e: exit immediately if command returns nonzerol
# -u: treat unset variables as errors
# -x: print each command before they are run
RUN set -eux \
    # install packages
    apk update \
    && apk add --no-cache curl \
    # create Jira directories and install Jira
    && mkdir -p "${JIRA_INSTALL}" \
    && mkdir -p "${JIRA_HOME}" \
    && chown -R jira "${JIRA_HOME}" \
    && chmod -R 700 "${JIRA_HOME}" \
    && echo -e "\njira.home=$JIRA_HOME" >> "${JIRA_INSTALL}/atlassian-jira/WEB-INF/classes/jira-application.properties" \
