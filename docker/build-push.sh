#!/bin/bash

# 遇到错误立即退出
# set -e

# 脚本所在目录 (docker/) - 使用更健壮的方式获取
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
# 项目根目录 (上一级目录)
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
# Dockerfile 和 .env 文件所在目录
DOCKER_DIR="$SCRIPT_DIR"

# 加载 .env 文件中的环境变量 (兼容性更好的方式)
echo "加载 .env 文件..."
if [ -f "$DOCKER_DIR/.env" ]; then
    # 读取 .env, 忽略注释行和空行, 移除行内注释, 导出变量
    while IFS= read -r line || [[ -n "$line" ]]; do
        line=$(echo "$line" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/\s*#.*//') # 去除前后空格和行内注释
        if [[ -z "$line" ]] || [[ "$line" =~ ^# ]]; then # 跳过空行和注释行
            continue
        fi
        if [[ "$line" =~ ^[a-zA-Z_][a-zA-Z0-9_]*= ]]; then # 导出 KEY=VALUE 格式的行
            export "$line"
        fi
    done < "$DOCKER_DIR/.env"
else
    echo "错误：找不到 .env 文件，请在 $DOCKER_DIR 目录下创建。"
    exit 1
fi

# --- 配置检查 --- #
if [ -z "$DOCKER_REGISTRY" ] || [ -z "$COMPOSE_PROJECT_NAME" ]; then
    echo "错误: DOCKER_REGISTRY 或 COMPOSE_PROJECT_NAME 未在 .env 文件中设置。"
    exit 1
fi
if [[ "$MYSQL_ROOT_PASSWORD" == "需要你设置的root密码" ]] || [[ "$MYSQL_PASSWORD" == "需要你设置的ry用户密码" ]] || [[ "$REDIS_PASSWORD" == "需要你设置的Redis密码" ]]; then
    echo "警告: .env 文件中的数据库或 Redis 密码似乎仍是默认值，请确保已修改为安全密码！"
    # read -p "按 Enter 继续，或按 Ctrl+C 退出脚本。"
fi

# --- 定义镜像名称 --- #
BACKEND_IMAGE_FULL_NAME="${DOCKER_REGISTRY}/${COMPOSE_PROJECT_NAME}-backend:${BACKEND_IMAGE_TAG:-latest}"
FRONTEND_IMAGE_FULL_NAME="${DOCKER_REGISTRY}/${COMPOSE_PROJECT_NAME}-frontend:${FRONTEND_IMAGE_TAG:-latest}"

echo "将要构建并推送以下镜像:"
echo "  后端: $BACKEND_IMAGE_FULL_NAME"
echo "  前端: $FRONTEND_IMAGE_FULL_NAME"

# --- 构建前端 --- #
# echo "\n>>> 开始构建前端项目 (ruoyi-ui)..."
# cd "$PROJECT_ROOT/ruoyi-ui"
# if [ ! -d "node_modules" ]; then
#   echo "未找到 node_modules，执行 npm install..."
#   npm install
# fi
# echo "执行 npm run build:prod..."
# npm run build:prod
# echo "前端项目构建完成。"
# cd "$PROJECT_ROOT"

# --- 构建后端 --- #
echo "\n>>> 开始构建后端项目 (ruoyi-admin)..."
cd "$PROJECT_ROOT" # 切换到项目根目录
if [ -f "mvnw" ]; then # 检查当前目录下的 mvnw
    echo "使用 Maven Wrapper 构建..."
    ./mvnw clean package -Dmaven.test.skip=true -f pom.xml
else
    echo "使用系统 mvn 命令构建..."
    mvn clean package -Dmaven.test.skip=true -f pom.xml
fi
if [ ! -f "ruoyi-admin/target/ruoyi-admin.jar" ]; then
    echo "错误：后端 JAR 文件构建失败或未找到。"
    exit 1
fi
echo "后端项目构建完成。"

--- 构建 Docker 镜像 --- #
echo "\n>>> 开始构建后端 Docker 镜像..."
docker build -t "$BACKEND_IMAGE_FULL_NAME" -f "$DOCKER_DIR/Dockerfile.backend" "$PROJECT_ROOT"

# echo "\n>>> 开始构建前端 Docker 镜像..."
# docker build -t "$FRONTEND_IMAGE_FULL_NAME" -f "$DOCKER_DIR/Dockerfile.frontend" "$PROJECT_ROOT"


echo "Docker 镜像构建完成。"


# --- 推送 Docker 镜像 --- #
echo "\n>>> 开始推送后端镜像 $BACKEND_IMAGE_FULL_NAME ..."
docker push "$BACKEND_IMAGE_FULL_NAME"


# echo "\n>>> 开始推送前端镜像 $FRONTEND_IMAGE_FULL_NAME ..."
# docker push "$FRONTEND_IMAGE_FULL_NAME"

echo "\n>>> 镜像推送完成!"


echo "后端镜像: $BACKEND_IMAGE_FULL_NAME"
# echo "前端镜像: $FRONTEND_IMAGE_FULL_NAME"

# (脚本末尾可以加一个简单的 echo 确认结束)
echo "\n脚本执行完毕。" 
sleep 20