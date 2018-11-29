docker build -t dyke2010/multi-client:latest -t dyke2010/multi-client:$SHA ./client/Dockerfile ./client
docker build -t dyke2010/multi-server:latest -t dyke2010/multi-server:$SHA ./server/Dockerfile ./server
docker build -t dyke2010/multi-worker:latest -t dyke2010/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push dyke2010/multi-client:latest
docker push dyke2010/multi-server:latest
docker push dyke2010/multi-worker:latest

docker push dyke2010/multi-client:$SHA
docker push dyke2010/multi-server:$SHA
docker push dyke2010/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dyke2010/multi-server:$SHA
kubectl set image deployments/client-deployment client=dyke2010/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dyke2010/multi-worker:$SHA