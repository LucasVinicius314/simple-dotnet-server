docker build -t counter-image -f Dockerfile .
# docker build --no-cache -t counter-image -f Dockerfile .
# docker build --no-cache -t counter-image -f Dockerfile .
# docker build --progress=plain -t counter-image -f Dockerfile .
docker run -it -d -p 80:80 counter-image