#!/bin/bash

sudo apt install zip -y
        zip $artifact_name.zip index.py

aws s3 cp $artifact_name.zip s3://$bucket_name/
