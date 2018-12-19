#! /bin/sh

echo "Cleaning AskOmics ..."
/usr/bin/amnesia -d ${ASKOMICS_DATA} \
                 -s ${ASKOMICS_DATABASE} \
                 -e ${ASKOMICS_ENDPOINT} \
                 -g ${ASKOMICS_USER_GRAPH} \
                 -p ${ASKOMICS_PREFIX} \
                 -u ${ASKOMICS_TPS_USERNAME} \
                 -w ${ASKOMICS_TPS_PASSWORD}

echo "Done!"