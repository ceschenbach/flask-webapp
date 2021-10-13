FROM ubuntu:latest
MAINTAINER Chad_Eschenbach

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -y python3-pip python3-dev python3-venv \
  && cd /usr/local/bin \
  && ln -s /usr/bin/python3 python \
  && pip3 --no-cache-dir install --upgrade pip \
  && rm -rf /var/lib/apt/lists/*
COPY ./requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
ADD . /app
ADD ./templates /app/templates
EXPOSE 8080
ENTRYPOINT ["python3"]
CMD [ "app.py" ]
