docker-amnesia
==============

Amnesia is a command line tool to clean up an AskOmics instance. This docker executes it at regular intervals using cron.

## Pull from dockerhub

```bash
docker pull askomics/amnesia
```

### Or build

```bash
docker build -t askomics-amnesia .
```

### Run

You have to mount the AskOmics data diretory to /askomics_data into the container, and provide .. via the environment variables.

`ASKOMICS_DATA`: path to the askomics data directory, default: /askomics_data
`ASKOMICS_DATABASE`: path to the database file, default: /askomics_data/database.db
`ASKOMICS_ENDPOINT`: endpoint url, default: http://localhost:8890/sparql
`ASKOMICS_USER_GRAPH`: AskOmics user graph, default: urn:sparql:askomics:users
`ASKOMICS_PREFIX`: AskOmics prefix, default: http://www.semanticweb.org/user/ontologies/2018/1#
`ASKOMICS_TPS_USERNAME`: triplestore username, default: dba
`ASKOMICS_TPS_PASSWORD`: triplestore password, default: dba

use the `CRON_STRING` variable to change the script execution frequency. default is `* * * * *` (every minute)

Example:

```bash
docker run --name amnesia \
           -v ~/askomics_data:/askomics_data \
           -e ASKOMICS_ENDPOINT=http://172.17.0.1:8890/sparql \
           -e CRON_STRING="0 0 * * *" \
           -e ASKOMICS_TPS_USERNAME=admin \
           -e ASKOMICS_TPS_PASSWORD=secretpassword \
            askomics-amnesia
```