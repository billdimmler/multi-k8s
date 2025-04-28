docker build -t bdimmler/multi-client:latest -t bdimmler/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bdimmler/multi-server:latest -t bdimmler/multi-server:$SHA-f ./server/Dockerfile ./server
docker build -t bdimmler/multi-worker:lastest -t bdimmler/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bdimmler/multi-client:latest
docker push bdimmler/multi-server:latest
docker push bdimmler/multi-worker:latest
docker push bdimmler/multi-client:$SHA
docker push bdimmler/multi-server:$SHA
docker push bdimmler/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=bdimmler/multi-server:$SHA
kubectl set image deployments/client-deployment client=bdimmler/multi-client:$SHA
kubectl set image deplyments/worker-deployment worker=bdimmler/multi-worker:$SHA