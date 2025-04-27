# RuoYi-Vue与BladeX集成Docker部署文档

本文档详细说明如何使用Docker部署RuoYi-Vue与BladeX集成的应用。

## 目录结构

```
RuoYi-Vue
├── Dockerfile           # Docker镜像构建文件
├── docker-compose.yml   # Docker Compose配置文件
├── docker-entrypoint.sh # Docker容器启动脚本
├── .env                 # 环境变量配置文件(需要自行创建)
└── sql/                 # 数据库初始化脚本目录
```

## 准备工作

1. 安装Docker和Docker Compose
2. 准备MySQL数据库初始化脚本(已包含在项目的sql目录)
3. 配置环境变量

## 环境变量配置

创建`.env`文件，内容如下(根据实际情况修改):

```dotenv
# 应用运行端口(宿主机端口映射)
PORT=80

# 数据库配置
DB_NAME=ry-vue
DB_USERNAME=root
DB_PASSWORD=password
MYSQL_PORT=3306

# Redis配置
REDIS_PASSWORD=
REDIS_PORT=6379

# BladeX认证配置
BLADE_AUTH_URL=https://auth.we-safer.net/oauth/token
BLADE_CLIENT_ID=chem_ruoyi
BLADE_CLIENT_SECRET=chem_ruoyi_secret
BLADE_REDIRECT_URI=http://your-domain/auth/blade-callback

# BladeX API配置
BLADE_API_URL=https://we-safer.net/api
BLADE_API_CLIENT_ID=chem_ruoyi
BLADE_API_CLIENT_SECRET=chem_ruoyi_secret

# 构建时前端API地址
API_URL=http://your-domain/api
```

## 部署步骤

### 1. 构建并启动服务

```bash
# 构建镜像并启动容器
docker-compose up -d

# 查看容器状态
docker-compose ps

# 查看应用日志
docker-compose logs -f ruoyi-app
```

### 2. 停止服务

```bash
docker-compose down
```

### 3. 重新构建并启动

```bash
docker-compose up -d --build
```

## 配置说明

### Docker镜像构建参数

在`docker-compose.yml`中，`ruoyi-app`服务的`build.args`部分定义了构建时传递给Dockerfile的参数:

- `API_URL`: 前端API地址
- `BLADE_AUTH_URL`: BladeX认证服务地址
- `BLADE_REDIRECT_URI`: BladeX认证回调地址
- `BLADE_CLIENT_ID`: BladeX客户端ID
- `BLADE_CLIENT_SECRET`: BladeX客户端密钥

### 容器运行环境变量

在`docker-compose.yml`中，`ruoyi-app`服务的`environment`部分定义了容器运行时的环境变量:

- 数据库连接信息
- Redis连接信息
- BladeX认证和API配置

## 数据持久化

以下目录/文件会被持久化:

- MySQL数据: `mysql-data`卷
- Redis数据: `redis-data`卷
- 应用日志: `./logs`目录
- 上传文件: `./uploadPath`目录

## 注意事项

1. **BladeX地址配置**: 确保BladeX相关地址配置正确且可以从容器内部访问
2. **端口映射**: 默认将容器的8080端口映射到宿主机的80端口，可以通过`.env`文件中的`PORT`变量修改
3. **安全性**: 生产环境部署时，建议修改默认的数据库密码和Redis密码
4. **域名配置**: `BLADE_REDIRECT_URI`需要使用实际的可访问域名，确保BladeX系统可以正确重定向

## 高级配置

### 自定义数据库初始化脚本

如果需要在MySQL容器启动时执行额外的初始化脚本，可以将SQL文件放在`sql/`目录下，这些脚本会在容器首次启动时自动执行。

### 修改资源限制

如果需要限制容器的资源使用，可以在`docker-compose.yml`中添加资源限制配置:

```yaml
services:
  ruoyi-app:
    # 其他配置...
    deploy:
      resources:
        limits:
          cpus: '1'
          memory: 1G
```

### 使用外部数据库或Redis

如果希望使用外部的MySQL或Redis服务，可以修改`.env`文件中的相关配置，并在`docker-compose.yml`中删除对应的服务定义。

## 故障排查

### 应用无法访问

1. 检查容器运行状态: `docker-compose ps`
2. 查看应用日志: `docker-compose logs ruoyi-app`
3. 检查端口映射是否正确
4. 检查BladeX系统是否可访问

### 数据库连接失败

1. 检查数据库容器是否正常运行
2. 检查数据库连接配置是否正确
3. 尝试直接连接数据库容器进行测试: `docker exec -it ruoyi-mysql mysql -uroot -p`

### BladeX认证失败

1. 检查BladeX相关配置是否正确
2. 确认BladeX系统是否正常运行
3. 检查网络连接是否正常
4. 查看应用日志中的BladeX认证相关信息 