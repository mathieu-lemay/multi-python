all:
	docker build -f Dockerfile -t acidrain/multi-python .
	docker build -f Dockerfile.slim -t acidrain/multi-python:slim .
	docker build -f Dockerfile.alpine -t acidrain/multi-python:alpine .

push:
	docker push acidrain/multi-python
	docker push acidrain/multi-python:slim
	docker push acidrain/multi-python:alpine

clean:
	docker rmi acidrain/multi-python{,:{slim,alpine}}
