docker build --progress=plain -t counter-image -f Dockerfile .
docker run -it -d -p 80:80 counter-image