FROM buildpack-deps:jessie

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 7.0.3

RUN apt-get update && apt-get install -y libgeos-dev libgdal-dev libmapnik2.2 \
    python-mapnik python-gdal python-dev

RUN curl -SL 'https://bootstrap.pypa.io/get-pip.py' | python2
RUN pip install --upgrade pip==$PYTHON_PIP_VERSION

RUN pip install gunicorn

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD COPY requirements.txt /usr/src/app/
ONBUILD RUN pip install -r requirements.txt
ONBUILD COPY . /usr/src/app
