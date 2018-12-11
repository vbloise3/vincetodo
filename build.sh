#!/bin/bash
pip install --upgrade awscli
aws --version
pip install virtualenv
virtualenv /tmp/venv
. /tmp/venv/bin/activate
pip install -r requirements.txt
pip install -r requirements-test.txt
pip install chalice
export PYTHONPATH=.
py.test tests/ || exit 1
chalice package /tmp/packaged
aws cloudformation package --template-file /tmp/packaged/sam.json --s3-bucket "${APP_S3_BUCKET}" --output-template-file transformed.yaml