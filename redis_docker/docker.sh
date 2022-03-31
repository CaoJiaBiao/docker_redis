#!/usr/bin/env bash

project_path=$(
  cd "$(dirname "$0")"
  pwd
)

cd "${project_path}"

bash=${1}

set -e

version=5.0.9
if [[ "${bash}" == "pull" ]]; then
  docker pull redis:${version}
  exit 0
fi

MSYS_NO_PATHCONV=1 docker run -itd -p 6379:6379 \
  -v /d/redis/redis.conf:/etc/redis/redis.conf -v /d/redis/data:/data \
  --name redis_${version} \
  -d redis:${version} redis-server /etc/redis/redis.conf --appendonly yes --requirepass 123456
