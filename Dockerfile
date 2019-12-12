FROM balenalib/raspberry-pi-alpine-python

ENV PYTHONUNBUFFERED 1

RUN mkdir /qira-django

WORKDIR /qira-django

COPY requirements.txt /qira-django/

RUN apk update && \
    apk add --virtual build-deps gcc python-dev musl-dev && \
    apk add postgresql-dev
RUN python3 -m pip install -r requirements.txt

COPY . /qira-django/

CMD python manage.py makemigrations; python manage.py migrate; python manage.py runserver 0.0.0.0:8000