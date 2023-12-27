#!/bin/bash

# Start mongo
service mongodb start

# Start web app
/usr/bin/python3 caldera.py
