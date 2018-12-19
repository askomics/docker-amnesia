FROM alpine
MAINTAINER Xavier Garnier 'xavier.garnier@irisa.fr'

ENV AMNESIA_GIT_URL="https://github.com/askomics/amnesia.git" \
    AMNESIA_DIR="/usr/local/amnesia" \
    ASKOMICS_DATA="/askomics_data" \
    ASKOMICS_DATABASE="/askomics_data/database.db" \
    ASKOMICS_ENDPOINT="http://localhost:8890/sparql" \
    ASKOMICS_USER_GRAPH="urn:sparql:askomics:users" \
    ASKOMICS_PREFIX="http://www.semanticweb.org/user/ontologies/2018/1#" \
    ASKOMICS_TPS_USERNAME="dba" \
    ASKOMICS_TPS_PASSWORD="dba" \
    CRON_TMP_FILE="/crontab.template" \
    CRON_DIR="/etc/cron.d" \
    CRON_FILE="/etc/cron.d/amnesia-cron" \
    CRON_LOG="/var/log/cron.log" \
    CRON_STRING="* * * * *" \
    SCRIPT_TMP_FILE="/entrypoint.template" \
    SCRIPT_ENTRYPOINT="/entrypoint.sh" \
    SCRIPT_TMP_RUN="/run.template" \
    SCRIPT_RUN="/run.sh"

ADD crontab ${CRON_TMP_FILE}
ADD entrypoint.sh ${SCRIPT_TMP_FILE}
ADD run.sh ${SCRIPT_TMP_RUN}

RUN apk add --update git python3 gettext libintl && \
    rm -rf /var/cache/apk/* && \
    git clone --single-branch --depth=1 ${AMNESIA_GIT_URL} ${AMNESIA_DIR} && \
    cd ${AMNESIA_DIR} && \
    python3 setup.py install && \
    mkdir ${CRON_DIR} && \
    touch /var/log/cron.log

WORKDIR ${AMNESIA_DIR}
CMD cat ${SCRIPT_TMP_FILE} | envsubst > ${SCRIPT_ENTRYPOINT} && chmod +x ${SCRIPT_ENTRYPOINT} && ${SCRIPT_ENTRYPOINT}
