#!/bin/bash


echo 'Starting databases and balancer first'
(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d micado_db mongodb balancer)


sleep 60s

echo 'starting api_manager, identity_server, monitoring system, data api'
(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d countly_api countly_frontend identity_server api_gateway data_api)

sleep 60s

echo 'Now starting applications'
(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d nginx data_migrants data_pa data_ngo watchtower)

sleep 60s

echo 'not started at the moment the translation system, db management, chatbot, upload_service, dashboard'
echo 'if you want to start postgresql db management use:'
echo '(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d db_admin)'
(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d db_admin)

echo 'if you want to start mongo db management use:'
echo 'docker-compose -f docker-compose.yml up -d mongo-express'

echo 'if you want to start translation system:'
echo '(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d git weblate cache)'
#(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d git weblate cache)

echo 'if you want to start dashboard:'
echo '(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d dashboard)'
#(set -a; source prod.env; set +a; docker-compose -f docker-compose.yml up -d dashboard)

