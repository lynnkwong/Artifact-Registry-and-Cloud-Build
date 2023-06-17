FROM python:3.11-slim

# Define build argument.
ARG SA_KEY_BASE64

# Create a temp key file with the service account key.
RUN echo $SA_KEY_BASE64 | base64 -d> /tmp/sa-artifact-registry.json

# Set the environment variable for the service account key.
ENV GOOGLE_APPLICATION_CREDENTIALS=/tmp/sa-artifact-registry.json

RUN pip install --no-cache-dir -U pip && \
    pip install --no-cache-dir -U keyrings.google-artifactregistry-auth

RUN pip install --no-cache-dir -U \
    --index-url=https://europe-north1-python.pkg.dev/superdataminer/standard-python-repo/simple/ \
    div-mod==0.1.0

# Remove the service acccount key file.
RUN rm /tmp/sa-artifact-registry.json

CMD [ "div-mod-example" ]
