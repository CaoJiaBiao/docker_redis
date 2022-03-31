# go的docker开发环境
1. 在开发机上安装docker
2. 执行本目录下的docker.sh脚本 

需注意：该镜像共享了开发机的git账号信息，如果不需要，则删除docker.sh里的
```shell
-v ~/.ssh:/root/.ssh
```
即可

## 使用方法
### 使用方法1
```shell
sh docker.sh 
```
功能：构建（没有构建好的镜像才进行构建）、创建并进入非一次性的容器

### 使用方法2
```shell
sh docker.sh new
```
功能：从已有构建好的镜像创建一个一次性的容器，可多次创建

## QA
```
Q：用完就删除、一次性容器的含义？
A：主动在docker内执行exit后，该容器就被删除

Q：windows上无法执行sh
A：windows上可使用git bash来使用sh

Q：有一些其它需求无法满足
A：定制开发docker.sh和Dockerfile即可