####################### WebApp

# Install Operating system and dependencies
FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Copy files to container and build
RUN mkdir /web-app/
COPY /WebApp /web-app/
WORKDIR /web-app/
RUN flutter build web

WORKDIR /

RUN mkdir /wwwroot

RUN mv -v /web-app/build/web/* /wwwroot

####################### End WebApp
####################### App

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build-env
WORKDIR /App

ENV ASPNETCORE_URLS http://+:80

# Copy everything
COPY /App ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
COPY --from=build-env /App/out .

ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]

####################### End App
