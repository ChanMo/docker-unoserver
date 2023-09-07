import os
import tempfile
import subprocess as sp
from werkzeug.utils import secure_filename
from flask import Flask, request, send_file


app = Flask(__name__)


@app.route("/")
def index():
    # TODO write a html
    return 'Welcome to chanmo/unoserver'


@app.route("/convert/<filetype>", methods=['POST'])
def convert_to(filetype):
    if 'file' not in request.files:
        return {
            'success': False,
            'message': 'file is required.'
        }

    file = request.files['file']
    infile = tempfile.NamedTemporaryFile()
    file.save(infile.name)
    #filename = f'./uploads/{secure_filename(file.filename)}'
    #file.save(filename)
    outfile = tempfile.NamedTemporaryFile(suffix=f'.{filetype}')
    sp.run(['unoconvert', infile.name, '--convert-to', filetype, outfile.name], check=False)
    return send_file(outfile.name, mimetype=f'application/{filetype}')
