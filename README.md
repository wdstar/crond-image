# crond-image
crond Docker image.

https://hub.docker.com/r/whitestar/crond

## Development

```bash
$ docker-compose build
$ docker-compose up -d
$ docker-compose exec crond bash
root@990e8fb8c4fc:/# tail -f /tmp/test.log
...
```

## Deployment examples

### Kubernetes

```bash
$ kubectl apply -k k8s/
$ kubectl logs crond-<pod id> -c tail
...
$ kubectl delete -k k8s/
```
