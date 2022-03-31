#!/usr/bin/env bash

function error_exit() {
	echo "$1" 1>&2
	exit 1
}

project_path=$(
	cd "$(dirname "$0")" || error_exit "$LINENO: $?"
	pwd
)
cd "${project_path}" || error_exit "$LINENO: $?"

go_version=v1.17.3
bash=${1}
timestamp=$(date '+%Y%m%d%H%M%S')
goBuilderId=gobuilder:${go_version}

# 没有镜像
imageName=$(docker images --format "{{.Repository}}:{{.Tag}}" | grep ${goBuilderId} | grep -v grep)
if [[ "$imageName" == "" ]]; then
	echo "开始构建镜像:${goBuilderId}"
	MSYS_NO_PATHCONV=1 docker build --platform linux/amd64 -t gobuilder:${go_version} .
fi

# 指定新生成一个一次性的容器
if [[ "${bash}" == "new" ]]; then
	echo "生成并进入一次性使用的容器"
	MSYS_NO_PATHCONV=1 docker run --rm --platform linux/amd64 -it --name gobuilder."${timestamp}" -v "${GOPATH}":/go -v ~/.ssh:/root/.ssh ${goBuilderId}
	exit 0
fi

# 有已运行的容器
p=$(docker ps | grep ${goBuilderId} | grep -v grep | awk '{print $1}')
if [[ "$p" != "" ]]; then
	echo "进入正运行的容器"
	MSYS_NO_PATHCONV=1 docker exec -it "$p" bash
	exit 0
fi

# 有已存在但停止运行的容器
p=$(docker ps -a | grep ${goBuilderId} | grep -v grep | awk '{print $1}')
if [[ "$p" != "" ]]; then
	echo "进入已存在但停止运行的容器"
	MSYS_NO_PATHCONV=1 docker start "$p" -i
	exit 0
fi

echo "生成并进入非一次性使用的容器"
MSYS_NO_PATHCONV=1 docker run --platform linux/amd64 -it --name gobuilder -v "${GOPATH}":/go -v ~/.ssh:/root/.ssh ${goBuilderId}
exit 0
