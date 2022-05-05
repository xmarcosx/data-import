
wget -O artifacts/edfi.dataimport.nupkg  https://pkgs.dev.azure.com/ed-fi-alliance/Ed-Fi-Alliance-OSS/_apis/packaging/feeds/EdFi/nuget/packages/DataImport.Web/versions/1.3.0/content;
sudo chmod -R 664 *
unzip artifacts/edfi.dataimport.nupkg -d artifacts/edfi_data_import;

