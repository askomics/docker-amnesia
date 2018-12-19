#! /bin/sh

cat ${CRON_TMP_FILE} | envsubst > ${CRON_FILE}
cat ${SCRIPT_TMP_RUN} | envsubst > ${SCRIPT_RUN}
chmod 0644 ${CRON_FILE}
crontab ${CRON_FILE}
chmod +x ${SCRIPT_RUN}
crond && tail -f ${CRON_LOG}
