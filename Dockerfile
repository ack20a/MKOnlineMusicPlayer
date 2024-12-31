FROM php:7.4-apache

# 设置容器名称（可选，与 docker-compose 对应）
# LABEL maintainer="Your Name <your.email@example.com>"
# LABEL org.label-schema.name="MKOnlineMusicPlayer"

# 将当前目录复制到容器的 /var/www/html/
COPY . /var/www/html/

# 将 Apache 配置文件复制到容器
COPY apache.conf /etc/apache2/sites-available/000-default.conf.bak

# 启用 headers 模块，备份并替换 Apache 配置文件，然后启动 Apache
RUN  \
  ((a2query -m | grep -q 'headers') || a2enmod headers) \
  && cp -v /etc/apache2/sites-available/000-default.conf.bak /etc/apache2/sites-available/000-default.conf \
  && source /etc/apache2/envvars \
  && service apache2 restart
# 也可以使用停止和前台运行，但推荐restart，避免权限问题
  # && service apache2 stop \
  # && source /etc/apache2/envvars \
  # && /usr/sbin/apache2 -D FOREGROUND 

# 暴露端口 (与 docker-compose 对应)
EXPOSE 80

# CMD 已经在基础镜像 php:7.4-apache 中定义为 "apache2-foreground"，此处不需要再定义
