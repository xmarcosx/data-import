# Data Import in Google Cloud

```sh
gcloud config set project $GOOGLE_CLOUD_PROJECT;

gcloud services enable artifactregistry.googleapis.com;

# create artifact registry repository
gcloud artifacts repositories create dataimport \
    --project=$GOOGLE_CLOUD_PROJECT \
    --repository-format=docker \
    --location=us-central1 \
    --description="Docker repository";

docker pull edfialliance/data-import:v1.3.0;
docker tag edfialliance/data-import:v1.3.0 us-central1-docker.pkg.dev/$GOOGLE_CLOUD_PROJECT/dataimport/dataimport;
docker push us-central1-docker.pkg.dev/$GOOGLE_CLOUD_PROJECT/dataimport/dataimport;

# gcloud builds submit \
#     --tag us-central1-docker.pkg.dev/$GOOGLE_CLOUD_PROJECT/dataimport/dataimport data_import/.;

# gcloud beta run deploy edfi-data-import \
#     --image us-central1-docker.pkg.dev/$GOOGLE_CLOUD_PROJECT/dataimport/dataimport \
#     --add-cloudsql-instances "$GOOGLE_CLOUD_PROJECT":us-central1:edfi-ods-db \
#     --port 80 \
#     --region us-central1 \
#     --cpu 2 \
#     --memory 1Gi \
#     --concurrency 50 \
#     --min-instances 0 \
#     --max-instances 1 \
#     --allow-unauthenticated \
#     --update-env-vars PROJECT_ID="$GOOGLE_CLOUD_PROJECT",API_URL=$(gcloud beta run services describe edfi-api --region us-central1 --format="get(status.url)") \
#     --set-secrets=DB_PASS=ods-password:latest,ENCRYPTION_KEY=admin-app-encryption-key:latest \
#     --service-account edfi-cloud-run@"$GOOGLE_CLOUD_PROJECT".iam.gserviceaccount.com \
#     --platform managed;


gcloud beta run deploy edfi-data-import \
    --image us-central1-docker.pkg.dev/$GOOGLE_CLOUD_PROJECT/dataimport/dataimport \
    --add-cloudsql-instances "$GOOGLE_CLOUD_PROJECT":us-central1:edfi-ods-db \
    --port 80 \
    --region us-central1 \
    --cpu 2 \
    --memory 1Gi \
    --concurrency 50 \
    --min-instances 0 \
    --max-instances 1 \
    --allow-unauthenticated \
    --update-env-vars PROJECT_ID="$GOOGLE_CLOUD_PROJECT",API_URL=$(gcloud beta run services describe edfi-api --region us-central1 --format="get(status.url)"),CONNECTIONSTRINGS__DEFAULTCONNECTION="host=/cloudsql/${GOOGLE_CLOUD_PROJECT}:us-central1:edfi-ods-db;port=5432;username=postgres;password=XXXXXXXXX;database=EdFi_DataImport;Application Name=EdFi.Ods.AdminApp",APPSETTINGS__DATABASEENGINE="PostgreSql",POSTGRES_HOST="/cloudsql/${GOOGLE_CLOUD_PROJECT}:us-central1:edfi-ods-db",POSTGRES_PORT="5432",POSTGRES_USER="postgres", \
    --set-secrets=POSTGRES_PASSWORD=ods-password:latest,APPSETTINGS__ENCRYPTIONKEY=admin-app-encryption-key:latest \
    --service-account edfi-cloud-run@"$GOOGLE_CLOUD_PROJECT".iam.gserviceaccount.com \
    --platform managed;
```
