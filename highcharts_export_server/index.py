import os
import uuid
import json
import logging
import base64
from subprocess import check_output, CalledProcessError, STDOUT
from bottle import run, post, get, put, delete, response, request, static_file
from multiprocessing import Queue, Process

log = logging.getLogger('server')
log.addHandler(logging.StreamHandler())
log.setLevel(logging.DEBUG)


@post('/')
def get_highchart_image():
    
    error = None
    postdata = request.body.read().decode('utf-8')
    data = json.loads(postdata)
    file_path = os.path.join(os.sep, "tmp", uuid.uuid4().hex[:6].upper())

    command = [
        'highcharts-export-server',
        '-type',
        data['type'],
        '-options',
        json.dumps(data['options']),
        '-globalOptions',
        json.dumps(data['globaloptions']),
        '-outfile',
        file_path
    ]

    try:
        check_output(command)
    except CalledProcessError as e:
        error = e.stdout.decode()
    except Exception as e:
        error = repr(e)

    handle = open(file_path, 'rb')
    content = handle.read()

    print(content.decode('utf-8'))

    base_64 = base64.b64encode(content).decode('utf-8')

    os.remove(file_path)

    return json.dumps({
        'options': data['options'],
        'globalOptions': data['globaloptions'],
        'format_type': data['type'],
        'base64': base_64,
        'error': error,
    })

run(host='0.0.0.0', port=7801, server='gunicorn', workers=2, timeout=600)
