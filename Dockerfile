# Use the official PostgreSQL image as a base
FROM postgres:9.4.17-alpine

RUN whoami

# Jira dockerfile inspired by https://github.com/cptactionhank/docker-atlassian-jira-software

# Jira environment variables
# ENV JIRA_HOME /var/atlassian/jira
# ENV JIRA_INSTALL /opt/atlassian/jira
# ENV JIRA_VERSION 7.8.1

# # Install packages, create Jira directories and install Jira
# RUN set -eux \
#     && apk update \
#     && apk add --no-cache curl \
#     && mkdir -p "${JIRA_HOME}" \
#     && chmod -R 700 "${JIRA_HOME}" \
#     &&
