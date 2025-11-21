#!/bin/bash

while [ ! -f "$OPERATOR_CONFIG" ]; do
  echo "Waiting for ${OPERATOR_CONFIG} to be created..."
  sleep 3
done

/opt/sliver-server builder -c $OPERATOR_CONFIG
