#!/bin/bash
docker build --no-cache -t mgryniak/mgr-dev-desktop .
docker push mgryniak/mgr-dev-desktop