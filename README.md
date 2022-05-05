# Data Import in Google Cloud

```sh
gcloud config set project <walkthrough-project-id/>;

bash data_import/init.sh;
sudo chmod -R 664 *;

gcloud builds submit --tag gcr.io/data-import-sandbox/edfi-data-import data_import/;

gcloud beta run deploy edfi-data-import \
    --image gcr.io/data-import-sandbox>/edfi-data-import \
    --add-cloudsql-instances data-import-sandbox:us-central1:edfi-ods-db \
    --port 80 \
    --region us-central1 \
    --cpu 2 \
    --memory 1Gi \
    --concurrency 50 \
    --min-instances 0 \
    --max-instances 1 \
    --allow-unauthenticated \
    --update-env-vars PROJECT_ID=data-import-sandbox,API_URL=$(gcloud beta run services describe edfi-api --region us-central1 --format="get(status.url)") \
    --set-secrets=DB_PASS=ods-password:1,ENCRYPTION_KEY=admin-app-encryption-key:1 \
    --service-account edfi-cloud-run@data-import-sandbox.iam.gserviceaccount.com \
    --platform managed;

```
