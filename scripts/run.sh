#!/bin/sh

set -e

python manage.py wait_for_db
python manage.py collectstatic --noinput
python manage.py migrate

# app/wsgin.py
gunicorn app.wsgi:application --bind :8000 --workers 3
