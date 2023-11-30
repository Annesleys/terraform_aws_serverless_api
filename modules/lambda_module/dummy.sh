#!/bin/bash

sudo apt install zip -y
        zip $artifact_name ../index.py

aws s3 cp $artifact_name s3://$bucket_name/