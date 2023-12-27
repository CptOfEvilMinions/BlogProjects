# Honeypots
## Cowire - prod
0. docker-compose -f docker-compose-cowrie.yml

## Responder - prod
0. docker-compose -f docker-compose-responder.yml up

## Responder - dev
0. docker build -t responder .
0. docker run -d -p 445:445 -p 389:389 -p 139:139 -p 138:138 -p 137:137 responder

# to do:
* Web honeypot
