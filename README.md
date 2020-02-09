# crond-image
crond Docker image.

## Development

```
$ docker-compose build
$ docker-compose up -d
$ docker-compose exec crond bash
root@990e8fb8c4fc:/# tail -f /tmp/test.log
...
```
