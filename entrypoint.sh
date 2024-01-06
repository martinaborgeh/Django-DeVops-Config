#!/bin/bash

# Apply database migrations

python manage.py makemigrations
python manage.py migrate --noinput
python manage.py collectstatic --noinput
python manage.py createcachetable

if [ "$DJANGO_SUPERUSER_USERNAME" ]
then
    python manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL
fi
    

# Start Gunicorn with the specified configuration
gunicorn --access-logfile - --workers 3 --threads 3 --worker-connections=10 --bind unix:/var/run/gunicorn.sock Django_PM_Project.wsgi:application
daphne -b unix:/var/run/websocket.sock Django_PM_Project.asgi:application     
  