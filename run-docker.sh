#!/bin/bash

echo "===== 启动RuoYi-Vue Docker容器 ====="

# 检查是否已有镜像包参数
if [ "$1" != "" ]; then
  IMAGE_TAR=$1
  echo "正在加载镜像: $IMAGE_TAR"
  docker load -i $IMAGE_TAR
fi

# 启动容器
echo "正在启动容器..."
docker-compose up -d

echo "===== 所有服务启动完成 ====="
echo "前端访问地址: http://localhost"
echo "后端访问地址: http://localhost:8088"
echo "默认账号密码: admin / admin123"

# 显示容器运行状态
echo "===== 容器运行状态 ====="
docker-compose ps 