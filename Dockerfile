FROM tensorflow/tensorflow
ARG DEBIAN_FRONTEND=noninteractive
# Install apt dependencies
RUN apt-get update && apt-get install -y \
    git \
    gpg-agent \
    python3-cairocffi \
    protobuf-compiler \
    python3-pil \
    python3-lxml \
    python3-tk \
    wget
# Install gcloud and gsutil commands
# https://cloud.google.com/sdk/docs/quickstart-debian-ubuntu
#RUN apt-get update && apt-get install -y lsb-release && apt-get clean all
RUN echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y
WORKDIR /pipeline
COPY ./ ./
#RUN pip install -r requirements.txt
RUN /usr/bin/python3 -m pip install --upgrade pip
RUN pip install google-cloud-storage
RUN pip install google-cloud
RUN pip install gcsfs
RUN pip install dask[dataframe]
RUN pip install google-api-python-client
RUN pip install matplotlib
RUN pip install seaborn
RUN pip install pandas
RUN pip install sklearn
RUN pip install wget
#RUN pip install dvc
RUN pip install "dask[dataframe]" --upgrade
ENV TF_CPP_MIN_LOG_LEVEL 3
