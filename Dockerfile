# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM python:3.6

# If you prefer miniconda:
#FROM continuumio/miniconda3

LABEL Name=nsupdate.info Version=0.0.1
EXPOSE 8000

WORKDIR /app
ADD . /app

# Using pip:
#RUN python3 -m pip install -r requirements.txt
RUN pip install -r requirements.txt
RUN pip install -e .
RUN python manage.py migrate
RUN python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@example.com', 'admin')"
#CMD ["python3", "-m", "nsupdate.info"]
#CMD ["python3", "-m http.server"]
#CMD python -m http.server
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]

# Using pipenv:
#RUN python3 -m pip install pipenv
#RUN pipenv install --ignore-pipfile
#CMD ["pipenv", "run", "python3", "-m", "nsupdate.info"]

# Using miniconda (make sure to replace 'myenv' w/ your environment name):
#RUN conda env create -f environment.yml
#CMD /bin/bash -c "source activate myenv && python3 -m nsupdate.info"
