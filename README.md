In this project I learnt basic usage of docker. How to create docker image from my .net wepapi (make docker file), and use that image to create docker container, and run that container on docker. Also I published docker image to docker hub.

What is docker?

Docker is a containerization platform, meaning that it enables you to package your applications into images and run them as “containers” on any platform that can run Docker.


What I do in projecz:



created DockerFile:

# Get base SDK Image from Microsoft
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env 
WORKDIR /app

# Copy the CSPROJ file and restore any dependencies (via NUGET)
COPY *.csproj ./
RUN dotnet restore

# Copy the project files and build our release
COPY . ./
RUN dotnet publish -c Release -o out

# Generate runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
EXPOSE 80
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "DockerAPI.dll"]

also I created dockerignore to make my container lighter.

dockerignore:

bin\
obj\  

I pushed my image to docker hub

if you want to make docker conatiner form my docker image it is enough to execute this in your comand line :

 docker run -p 8080:80 vherceglij1/dockerapi
