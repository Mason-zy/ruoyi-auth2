#!/bin/bash

# 遇到错误立即退出
set -e

# 脚本所在目录 (docker/)
SCRIPT_DIR="$(cd \"$(dirname \"${BASH_SOURCE[0]}\")\" && pwd)"

# 切换到 docker-compose.yml 所在目录
cd "$SCRIPT_DIR"

# 加载 .env 文件中的环境变量 (更健壮的方式)
echo "加载 .env 文件..."
if [ -f ".env" ]; then
    set -a # 自动导出后续定义的所有变量
    # 读取 .env, 忽略注释行和空行, 移除行内注释
    source <(grep -v '^\s*#' ".env" | grep -v '^$' | sed 's/\s*#.*//')
    set +a # 关闭自动导出
else
    echo "错误：找不到 .env 文件。"
    exit 1
fi

# --- 配置检查 --- #
if [ -z "$DOCKER_REGISTRY" ]; then
    echo "错误: DOCKER_REGISTRY 未在 .env 文件中设置。"
    exit 1
fi

echo "将从仓库 $DOCKER_REGISTRY 拉取最新镜像并部署/更新服务..."

# --- 登录仓库 (可选) --- #
echo "\n>>> 尝试登录 Docker 仓库 $DOCKER_REGISTRY ..."
echo "请输入 $DOCKER_REGISTRY 的用户名和密码 (如果需要):"
# 可选：如果仓库需要认证，取消下一行注释
# docker login $DOCKER_REGISTRY

# --- 拉取最新镜像 --- #
echo "\n>>> 开始拉取 docker-compose.yml 中定义的所有服务的最新镜像..."
docker-compose pull
echo "镜像拉取完成。"

# --- 启动/更新服务 --- #
echo "\n>>> 开始使用 docker-compose 启动或更新服务..."
docker-compose up -d --remove-orphans
# --remove-orphans 会移除在 compose 文件中已不存在的服务的容器

echo "\n>>> 服务部署/更新完成!"

# 显示运行中的容器状态 (可选)
echo "\n>>> 当前运行中的容器:"
docker-compose ps 