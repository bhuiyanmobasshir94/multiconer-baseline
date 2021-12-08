FROM ubuntu:20.04
ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

RUN apt update \
    && apt install -y htop python3-dev wget python3-pip

# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#     && mkdir root/.conda \
#     && sh Miniconda3-latest-Linux-x86_64.sh -b \
#     && rm -f Miniconda3-latest-Linux-x86_64.sh

COPY . .
RUN /bin/bash -c "pip install -r requirements.txt"


### Solution 1:
# FROM ubuntu:18.04
# FROM nvidia/cuda:10.2-cudnn7-runtime-ubuntu18.04
# ENV PATH="/root/miniconda3/bin:${PATH}"
# ARG PATH="/root/miniconda3/bin:${PATH}"

# RUN apt update \
#     && apt install -y htop python3-dev wget

# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#     && mkdir root/.conda \
#     && sh Miniconda3-latest-Linux-x86_64.sh -b \
#     && rm -f Miniconda3-latest-Linux-x86_64.sh

# RUN conda create -y -n ml python=3.7

# COPY . src/
# RUN /bin/bash -c "cd src \
#     && source activate ml \
#     && pip install -r requirements.txt"

### Solution 2:
# FROM python:3.8-slim-buster

# ENV PYTHONUNBUFFERED 1
# ENV PYTHONDONTWRITEBYTECODE 1

# RUN apt-get update \
#   # dependencies for building Python packages
#   && apt-get install -y build-essential \
#   # psycopg2 dependencies
#   && apt-get install -y libpq-dev \
#   # Translations dependencies
#   && apt-get install -y gettext \
#   # cleaning up unused files
#   && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
#   && rm -rf /var/lib/apt/lists/*

# WORKDIR /src

# COPY ./requirements ./requirements
# RUN pip install -r requirements/base.txt

# COPY . .

# EXPOSE 8004

# ENTRYPOINT ["/src/docker-entrypoint.sh"]
# # CMD python /src/manage.py runserver 0.0.0.0:8004
# CMD uvicorn museum_cms.asgi:application --host 0.0.0.0 --port 8004 --reload
# # CMD uvicorn museum_cms.asgi:application --reload