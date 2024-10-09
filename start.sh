#!/bin/bash

unoserver --daemon
gunicorn -w 4 -t 600 -b :5000 app:app
