# ScyllaDB Workshop Demo
Hi, and welcome!

If you ended up here, then it means that you likely attended to one of the [ScyllaDB Workshops](https://lp.scylladb.com/virtual-workshop-registration.html). :-)

This GitHub repo contains all the resources you need in order to reproduce the demonstrated contents. 

## Pre-requisites

1. You must have **[Docker](https://docker.com)** installed on your machine in order to get along
2. On top of Docker, do notice that the examples make use of `docker compose`. However, note that you must have **[Docker Compose]([url](https://docs.docker.com/compose/)https://docs.docker.com/compose/)** installed, rather than the old (no longer supported) `docker-compose` command-line. If you are using **Docker Desktop**, then you should be all set.
3. The provided files are going to spin up 2 ScyllaDB nodes (1 in each cluster), a CDC replicator job, a stressor and the **[ScyllaDB Monitoring Stack](monitoring.docs.scylladb.com/)**
   - It is highly-recommended to run the material under a reasonable powerful laptop with at least 12 cores and with 16GB RAM
   - Under Linux, configure the `fs.aio-max-nr` parameter to a high value with: `sudo sysctl -w fs.aio-max-nr=1000000000`. If you are running on a Mac and you end up hitting underlying VM limits, then you will have no choice but to either reduce the number of ScyllaDB containers by yourself, or to stick to an actual Linux VM.
   - The example was primarily tested under Linux and Mac OS X (including ARM64) installations. It might work on top of Windows, although you may find it easier to simply spin up a VM if that's your case.
   - The entire stack may require a fairly high amount of diskspace. Consider having at least 10G of storage room.
   - Once you feel comfortable running the provided `docker-compose.yaml` file, you may want to try playing with the `docker-compose-heavy.yaml` one, which demonstrates a 6-node ScyllaDB cluster, with 3 in each cluster. This setup is much more resource intensive, but should give you a fair idea of how a production-like topology would look like.

## Getting Started

To start the ScyllaDB clusters, the stress job, the CDC replicator and the Monitoring Stack, simply clone this repo and bring up the stack with `docker compose`. For example:

```shell
git clone https://github.com/fee-mendes/workshop-demo.git
cd workshop-demo
docker compose up -d
```

**Warning:** If you get a Compose error at this point, then it means your `docker-compose` installation is outdated. Refer back to the **Pre-requisites** section.

It may take a while for all containers to get built and start, depending on your network speeds to pull images from DockerHub and on your laptop processing power to build the necessary images.

Once everything is up and running, simply point your browser to http://localhost:3000 in order to behold the ScyllaDB Monitoring Stack!

## Running the DynamoDB Tic Tac Toe example

The repository also includes a `tictactoe` folder which is not included in the Compose stack by default. Here's how to get started with it:

- Ensure that you have Python3 and pip for Python3 installed on your local machine;
- Install the dependencies as provided within the `requirements.txt` file
- Start the application
- Point your browser to http://localhost:8080 and have fun!

For example:

```shell
cd tictactoe
pip3 install -r requirements.txt
python3 application.py --mode local --endpoint 127.0.0.1 --serverPort 8080 
```

In case running the tictactoe application fails with `Exception: There was an issue trying to retrieve the Games table.`, then simply retry the statement as it indicates the boto3 client decided to drop the connection while waiting for the target DynamoDB tables to be created. We'll fix it in the future :-)
