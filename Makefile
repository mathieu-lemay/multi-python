all:
	docker build -f Dockerfile -t acidrain/multi-python:uv .
	docker build -f Dockerfile.slim -t acidrain/multi-python:uv-slim .
	# docker build -f Dockerfile.alpine -t acidrain/multi-python:uv-alpine .

push:
	docker push acidrain/multi-python:uv
	docker push acidrain/multi-python:uv-slim
	# docker push acidrain/multi-python:uv-alpine

clean:
	docker rmi acidrain/multi-python:uv{,-{slim,alpine}}
