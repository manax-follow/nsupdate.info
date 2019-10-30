# pull official base image
FROM python:3.8.0-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

# install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /usr/src/app/requirements.txt
COPY requirements.d/ /usr/src/app/requirements.d
RUN pip install -r requirements.txt

# required for psycopg2
RUN pip install psycopg2-binary

# copy entrypoint.sh
COPY entrypoint.sh /usr/src/app/entrypoint.sh

# copy project
COPY src/nsupdate/ /usr/src/app/nsupdate
COPY manage.py /usr/src/app/
RUN echo "version = 'dev'" > /usr/src/app/nsupdate/_version.py

# install nsupdate from source
#COPY .git/ /usr/src/app/
#RUN pip install -e .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]

# # migrate database
# RUN python manage.py makemigrations
# RUN python manage.py migrate

# createsuperuser
# RUN python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'admin')"

# run app
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]