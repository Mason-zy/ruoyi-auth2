#!/bin/bash

echo "===== 开始构建RuoYi-Vue Docker镜像 ====="

# 确保.env.production文件存在
if [ ! -f ruoyi-ui/.env.production ]; then
  echo "Creating .env.production file..."
  cat > ruoyi-ui/.env.production << EOF
# 生产环境配置
ENV = 'production'

# API基础路径
VUE_APP_BASE_API = '/prod-api'

# BladeX认证相关配置
VUE_APP_BLADE_AUTH_URL = 'https://auth.we-safer.net/oauth/authorize'
VUE_APP_BLADE_CLIENT_ID = 'chem_ruoyi'
VUE_APP_BLADE_REDIRECT_URI = 'http://localhost/auth/blade-callback'
EOF
fi

# 1. 构建镜像
echo "===== 构建Docker镜像 ====="
docker-compose build

# 2. 创建并启动容器
echo "===== 启动Docker容器 ====="
docker-compose up -d

echo "===== 所有服务启动完成 ====="
echo "前端访问地址: http://localhost"
echo "后端访问地址: http://localhost:8088"
echo "默认账号密码: admin / admin123"

# 3. 打包镜像用于分发
echo "===== 打包镜像用于分发 ====="
VERSION=$(date +%Y%m%d)
echo "镜像版本: ${VERSION}"

# 保存镜像
echo "正在保存镜像..."
docker save \
  ruoyi-vue_ruoyi-backend \
  ruoyi-vue_ruoyi-frontend \
  mysql:5.7 \
  redis:6-alpine \
  -o ruoyi-vue-docker-${VERSION}.tar

echo "镜像已保存为: ruoyi-vue-docker-${VERSION}.tar"
echo "===== 构建完成 =====" 