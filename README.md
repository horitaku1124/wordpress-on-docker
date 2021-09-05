# wordpress-on-docker


#### usage

download wordpress file and unzip into wordpress-files
```
docker build --build-arg WP_FILE=wordpress -t wp-app .
docker-compose up -d
docker-compose exec wp-app bash
```


```
wp --allow-root core install \
  --url=http://localhost:9000/ \
  --title=自分のブログ名 \
  --admin_user=admin_user \
  --admin_password=admin_password \
  --admin_email=admin@example.com
```