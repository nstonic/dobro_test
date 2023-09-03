FROM docker.io/python:3.11.3

ENV \
    SECRET_KEY=empty \
    POSTGRES_URL='postgres://dobro:dobro@postgres:5432/dobro' \
    PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off

WORKDIR /opt/app
COPY ./requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY ./src ./src

WORKDIR /opt/app/src

RUN python manage.py collectstatic --noinput

EXPOSE 8000/tcp
