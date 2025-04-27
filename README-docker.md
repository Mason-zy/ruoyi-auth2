# RuoYi-Vue Docker部署指南

本文档提供了使用Docker容器化部署RuoYi-Vue项目的详细说明。

## 一、系统要求

- Docker 19.03+
- Docker Compose 1.25+
- 至少2GB可用内存
- 至少10GB可用磁盘空间

## 二、部署架构

系统由以下容器组成：

1. **ruoyi-backend**: 后端服务，基于Spring Boot
2. **ruoyi-frontend**: 前端服务，基于Vue+Nginx
3. **ruoyi-mysql**: MySQL数据库，包含预装数据
4. **ruoyi-redis**: Redis缓存服务

## 三、快速开始

### 1. 构建镜像

执行以下命令构建所有容器镜像：

```bash
# 添加执行权限
chmod +x build-docker.sh

# 执行构建脚本
./build-docker.sh
```

构建完成后，会生成一个tar格式的镜像包，用于分发。

### 2. 运行容器

如果已经构建了镜像，可以直接启动：

```bash
docker-compose up -d
```

如果使用分发的镜像包：

```bash
# 添加执行权限
chmod +x run-docker.sh

# 执行启动脚本，加载镜像包
./run-docker.sh ruoyi-vue-docker-20240922.tar
```

### 3. 访问系统

- 前端访问地址: http://localhost
- 后端接口地址: http://localhost:8088
- 默认管理员账号: admin
- 默认管理员密码: admin123

## 四、配置说明

### 1. 环境变量

系统支持通过环境变量配置各项参数，主要变量如下：

| 环境变量 | 说明 | 默认值 |
|---------|------|--------|
| SPRING_DATASOURCE_URL | 数据库连接URL | jdbc:mysql://ruoyi-mysql:3306/ry?useUnicode=true... |
| SPRING_DATASOURCE_USERNAME | 数据库用户名 | root |
| SPRING_DATASOURCE_PASSWORD | 数据库密码 | ruoyi@123 |
| SPRING_REDIS_HOST | Redis主机地址 | ruoyi-redis |
| BLADE_AUTH_URL | BladeX认证服务地址 | https://auth.we-safer.net/oauth/token |
| BLADE_CLIENT_ID | BladeX客户端ID | chem_ruoyi |
| BLADE_CLIENT_SECRET | BladeX客户端密钥 | chem_ruoyi_secret |
| BLADE_REDIRECT_URI | BladeX重定向URI | http://localhost/auth/blade-callback |
| BLADE_API_BASE_URL | BladeX API基础URL | https://we-safer.net/api |

可以在docker-compose.yml中修改这些变量，或者在启动容器时通过-e参数指定。

### 2. 持久化数据

系统使用Docker卷保存数据，确保容器重启后数据不丢失：

- **ruoyi-uploads**: 上传的文件
- **ruoyi-logs**: 系统日志
- **ruoyi-mysql-data**: 数据库文件
- **ruoyi-redis-data**: Redis数据

## 五、常见问题

### 1. 如何查看容器日志？

```bash
# 查看后端日志
docker logs ruoyi-backend

# 查看前端日志
docker logs ruoyi-frontend

# 查看数据库日志
docker logs ruoyi-mysql
```

### 2. 如何修改BladeX配置？

可以通过环境变量修改BladeX相关配置：

```bash
docker-compose down
export BLADE_AUTH_URL=https://auth.we-safer.net/oauth/token
export BLADE_CLIENT_ID=chem_ruoyi
export BLADE_CLIENT_SECRET=chem_ruoyi_secret
export BLADE_REDIRECT_URI=http://your-domain/auth/blade-callback
export BLADE_API_BASE_URL=https://we-safer.net/api
docker-compose up -d
```

### 3. 如何完全重置系统？

```bash
# 停止并删除所有容器
docker-compose down

# 删除所有卷（数据将永久删除）
docker volume rm ruoyi-vue_ruoyi-uploads ruoyi-vue_ruoyi-logs ruoyi-vue_ruoyi-mysql-data ruoyi-vue_ruoyi-redis-data

# 重新启动系统
docker-compose up -d
```

## 六、升级说明

当有新版本发布时，可以按照以下步骤升级：

1. 备份数据（如有必要）
2. 拉取新版本的镜像包
3. 停止当前运行的容器：`docker-compose down`
4. 加载新版本镜像：`docker load -i ruoyi-vue-docker-新版本.tar`
5. 启动新版本容器：`docker-compose up -d` 