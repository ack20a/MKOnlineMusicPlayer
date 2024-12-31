FROM php:7.4-apache

# 设置容器名称（可选，但建议）
LABEL maintainer="ack20a <your.email@example.com>"
LABEL org.opencontainers.image.source="https://github.com/your-repo/your-project" # 替换为你的仓库地址

# 复制项目文件
COPY . /var/www/html/

# 复制 Apache 配置文件
COPY apache.conf /etc/apache2/sites-available/000-default.conf.bak

# 安装并启用 Apache headers 模块
RUN a2enmod headers

# 暴露端口
EXPOSE 80

# 启动命令
CMD /bin/bash -c "service apache2 stop && cp -v /etc/apache2/sites-available/000-default.conf.bak /etc/apache2/sites-available/000-default.conf && source /etc/apache2/envvars && /usr/sbin/apache2 -D FOREGROUND"
