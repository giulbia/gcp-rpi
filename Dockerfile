FROM resin/rpi-raspbian

ARG CLOUD_SDK_VERSION=218.0.0
ENV CLOUD_SDK_VERSION=$CLOUD_SDK_VERSION

ARG INSTALL_COMPONENTS
RUN apt-get update -qqy && apt-get install -qqy \
        curl \
        gcc \
        python-dev \
        python-setuptools \
        apt-transport-https \
        lsb-release \
        openssh-client \
        git \
        gnupg \
    && easy_install -U pip && \
    pip install -U crcmod && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb https://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" > /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && apt-get install -y google-cloud-sdk=${CLOUD_SDK_VERSION}-0 $INSTALL_COMPONENTS && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version
VOLUME ["/root/.config"]

#RUN apt-get update
RUN apt-get install -y python python-pip alsa-utils build-essential
#RUN apt-get install python-dev
#RUN pip install numpy
#RUN apt-get install -y libblas-dev
#RUN apt-get install -y liblapack-dev
#RUN apt-get install -y gfortran
#RUN pip install librosa
#RUN pip install pandas
#RUN pip install sklearn
#RUN echo "deb http://ftp.debian.org/debian jessie-backports main" > /etc/apt/sources.list.d/backports.list
#
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8B48AD6246925553
#RUN apt-get update
#RUN apt-get install -y python-dill
#RUN pip install simplejson
#
#RUN pip install pydub
#RUN apt-get install -y libav-tools libavcodec-extra-56

ADD http://ftp.osuosl.org/pub/blfs/conglomeration/alsa-utils/alsa-utils-1.1.3.tar.bz2 /alsa/alsa-utils-1.1.3.tar.bz2
#ADD ftp://ftp.alsa-project.org/pub/utils/alsa-utils-1.1.3.tar.bz2 /alsa/alsa.tar.bz2
WORKDIR /alsa
RUN tar xvjf alsa-utils-1.1.3.tar.bz2
WORKDIR /alsa/alsa-utils-1.1.3
RUN apt-get -y install libncursesw5-dev libasound2-dev
RUN ./configure --disable-alsaconf --disable-bat --disable-xmlto --with-curses=ncursesw
RUN make
RUN make install