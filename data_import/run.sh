
envsubst < /app/DataImport.Web/appsettings.template.json > /app/DataImport.Web/appsettings.json

dotnet DataImport.Web.dll
