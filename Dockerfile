FROM python:3-alpine

WORKDIR /usr/src/app

# Copy over installation requirements
COPY requirements.txt ./

RUN pip install -U pip -r requirements.txt