FROM alpine:3.8

# Create user
RUN addgroup -S app && adduser -S -G app app

# Install things
RUN apk update && apk add python3

# Copy app
COPY app /app

# Workdir
WORKDIR /app

# Install pip requirements
RUN pip3 install -r requirements.txt

# Change perms and user
RUN chown app:app -R /app
USER app

# Run app
CMD ["/usr/bin/python3","-u","run-server.py"]
