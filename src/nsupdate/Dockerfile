# pull official base image
FROM python:3.8.0-alpine

# set work directory
WORKDIR /usr/src/app

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY requirements.txt /usr/src/app/requirements.txt
COPY requirements.d/ /usr/src/app/requirements.d
RUN pip install -r requirements.txt

# copy project
#COPY . /usr/src/app/
COPY manage.py /usr/src/app/
COPY src/nsupdate /usr/src/app/nsupdate/
RUN echo "version = 'dev'" > /usr/src/app/nsupdate/_version.py

# install nsupdate from source
#COPY .git/ /usr/src/app/
#RUN pip install -e .

# migrate database
RUN python manage.py migrate

# createsuperuser
RUN python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'admin')"

# run app
#CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
CMD python -m http.server