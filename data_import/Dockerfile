FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-alpine

ENV VERSION="1.3.0"

WORKDIR /app
COPY appsettings.template.json /app/appsettings.template.json
COPY run.sh /app/DataImport.Web/run.sh

COPY --from=gcr.io/berglas/berglas:latest /bin/berglas /bin/berglas

RUN apk add unzip dos2unix bash gettext postgresql-client jq icu gcompat tzdata  && \
    wget -O /app/DataImport.zip  https://pkgs.dev.azure.com/ed-fi-alliance/Ed-Fi-Alliance-OSS/_apis/packaging/feeds/EdFi/nuget/packages/DataImport.Web/versions/${VERSION}/content && \
    unzip /app/DataImport.zip -d /app/DataImport.Web && \
    rm -f /app/DataImport.zip && \
    dos2unix /app/DataImport.Web/*.json && \
    dos2unix /app/DataImport.Web/*.sh && \
    chmod 700 /app/DataImport.Web/*.sh **
 
EXPOSE "80"

WORKDIR /app/DataImport.Web

ENTRYPOINT exec /bin/berglas exec /app/DataImport.Web/run.sh
