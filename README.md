# aliyun-docker-mysql-master-slave

> 单机 Docker-Compose 快速拉起 MySQL 主从 + 阿里云 OSS 异地定时备份

##
- 1 台 ECS → 1 主 1 从（GTID，延迟 < 500 ms）
- 每天 2 点自动 `mysqldump` + `ossutil` 上传
- 7 天滚动清理，存储成本 ↓ 70 %
- 90 秒 `docker-compose up -d` 完成部署
##  一键启动
```bash
git clone https://github.com/1sin1-pxm/mysql-ms-on-aliyun-docker.git
ossutil config  # 按提示填 AccessKey、Endpoint
cd mysql-ms-on-aliyun
docker-compose up -d

