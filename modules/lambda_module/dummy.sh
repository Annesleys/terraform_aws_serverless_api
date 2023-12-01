#!/bin/bash

sudo apt install zip -y
        zip index.zip index.py

aws s3 cp index.zip s3://$bucket_name/
