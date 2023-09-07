#!/bin/bash

unoserver --daemon
gunicorn -w 2 -b :5000 app:app
