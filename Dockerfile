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
