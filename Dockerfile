FROM python:3.10-alpine
WORKDIR /app
# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBUG 0


# Install system packages required by Wagtail and Django.
RUN apk update \
    && apk add --virtual build-essential gcc python3-dev musl-dev \
    && apk add postgresql-dev \
    && pip install psycopg2


# install dependencies
COPY ./requirements.txt .
RUN pip install -r requirements.txt


# Copy project code
COPY . .



# collect static files
RUN python manage.py collectstatic --noinput

# add and run as non-root user
RUN adduser -D myuser
USER myuser

# run gunicorn
CMD gunicorn new_project.wsgi:application --bind 0.0.0.0:$PORT