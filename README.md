# Docker image GCP on Raspberry PI

Create a docker image with Google Cloud SDK for Raspberry Pi

Dockerfile from [cloud-sdk-docker](https://github.com/GoogleCloudPlatform/cloud-sdk-docker) and
 [rpi-raspbian-baby-cry-detection](https://github.com/mikklfr/rpi-raspbian-baby-cry-detection)

Useful links:
+ [google-cloud-sdk-dockerfile](https://medium.com/google-cloud/google-cloud-sdk-dockerfile-861a0399bbbb)


### How to use it

`docker pull giulbia/gcp-rpi`

`docker run -t -i --name gcloud-config giulbia/gcp-rpi gcloud auth login`

`docker run -ti --volumes-from gcloud-config giulbia/gcp-rpi gcloud config set project PROJECT-ID`

`docker run -ti --volumes-from gcloud-config giulbia/gcp-rpi gcloud config list`
