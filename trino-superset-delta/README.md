# trino-superset-delta

## Init
1. `docker compose pull`
1. `docker compose build`
1. `docker compose up -d`
1. `docker exec -it superset bash`
1.
```shell
superset fab create-admin \
    --username admin --firstname Superset \
    --lastname Admin --email admin@superset.com \
    --password admin
```
```shell
Recognized Database Authentications.
Admin User admin created.
```
1. `superset db upgrade && superset init`


## Create Minio S3 bucket structure
```shell
bronze
├── zeek
│   ├── conn
│   │   ├── json_streaming_conn.log
│   ├── dns
│   │   ├── json_streaming_dns.log
│   ├── http
│   │   ├── json_streaming_http.log
├── customers
│   ├── customers-100.csv
silver
├── zeek
│   ├── conn
│   ├── dns
│   ├── http
├── customers
├── iris
```


## References
* [datablist/sample-csv-files](https://github.com/datablist/sample-csv-files?tab=readme-ov-file)
* [customers-100.csv](https://drive.google.com/uc?id=1zO8ekHWx9U7mrbx_0Hoxxu6od7uxJqWw&export=download)
* [Delta Lake connector](https://trinodb.github.io/docs.trino.io/474/connector/delta-lake.html#delta-lake-file-system-configuration)
* [Hive connector](https://trinodb.github.io/docs.trino.io/474/connector/hive.html)
* []()
* []()
* []()
* []()
* []()
* []()
