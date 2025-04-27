#!/bin/sh
set -e

echo "Starting RuoYi Backend Application..."

# 等待MySQL服务启动
echo "Waiting for MySQL to start..."
while ! nc -z ruoyi-mysql 3306; do
  sleep 1
done
echo "MySQL started"

# 等待Redis服务启动
echo "Waiting for Redis to start..."
while ! nc -z ruoyi-redis 6379; do
  sleep 1
done
echo "Redis started"

# 根据环境变量更新配置文件（如果需要）
if [ ! -z "$SPRING_PROFILES_ACTIVE" ]; then
  echo "Using profile: $SPRING_PROFILES_ACTIVE"
fi

# 设置默认的Java选项
if [ -z "$JAVA_OPTS" ]; then
  JAVA_OPTS="-Djava.awt.headless=true"
else
  JAVA_OPTS="$JAVA_OPTS -Djava.awt.headless=true"
fi

echo "Starting with Java options: $JAVA_OPTS"

# 启动应用
echo "Starting application with external configuration..."
exec java ${JAVA_OPTS} -Djava.security.egd=file:/dev/./urandom \
     -Dspring.profiles.active=${SPRING_PROFILES_ACTIVE:-prod} \
     -Dspring.config.location=classpath:/application.yml,file:/app/config/application-prod.yml \
     -jar /app/app.jar