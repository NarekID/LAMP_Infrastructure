#!/bin/bash
cd /home/ubuntu_notejam_app
notejam_venv/bin/python3 notejam/manage.py makemigrations notes
notejam_venv/bin/python3 notejam/manage.py makemigrations pads
notejam_venv/bin/python3 notejam/manage.py makemigrations users
notejam_venv/bin/python3 notejam/manage.py migrate
sudo systemctl restart apache2