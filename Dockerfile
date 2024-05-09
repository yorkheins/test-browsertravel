#Imagen Distroless para Asp.NET Core
FROM mcr.microsoft.com/dotnet/runtime-deps:6.0-alpine AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine AS build
WORKDIR /src
COPY ["TestAspNetApp.csproj", "./"]
RUN dotnet restore "TestAspNetApp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "TestAspNetApp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "TestAspNetApp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
CMD ["./TestAspNetApp"]
