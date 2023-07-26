FROM ubuntu:latest

RUN apt update && apt install -y python3-pip golang-1.20
RUN pip3 install scylla-cqlsh

WORKDIR /usr/src/app
COPY ./schema.cql ./schema.cql
COPY ./replicate.sh ./replicate.sh
COPY ./scylla-cdc-go/ ./

WORKDIR /usr/src/app/examples/replicator
RUN /usr/lib/go-1.20/bin/go build

WORKDIR /usr/src/app
CMD ["/usr/src/app/replicate.sh"]
