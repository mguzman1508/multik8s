docker build -t mguzman1508/multi-client:latest -t mguzman1508/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mguzman1508/multi-server:latest -t mguzman1508/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mguzman1508/multi-worker:latest -t mguzman1508/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mguzman1508/multi-client:latest
docker push mguzman1508/multi-server:latest
docker push mguzman1508/multi-worker:latest

docker push mguzman1508/multi-client:$SHA
docker push mguzman1508/multi-server:$SHA
docker push mguzman1508/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mguzman1508/multi-server:$SHA
kubectl set image deployments/client-deployment client=mguzman1508/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mguzman1508/multi-worker:$SHA