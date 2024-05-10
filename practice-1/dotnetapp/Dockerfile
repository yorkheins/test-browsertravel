#Imagen Distroless para Asp.NET Core
FROM mcr.microsoft.com/dotnet/runtime-deps:8.0-alpine AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:8.0-alpine AS build
WORKDIR /src
COPY ["dotnetapp.csproj", "./"]
RUN dotnet restore "dotnetapp.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "dotnetapp.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "dotnetapp.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
CMD ["./dotnetapp"]
