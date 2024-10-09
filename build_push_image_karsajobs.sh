#!/bin/bash

# Membuat Docker image
docker build -t hijazp/karsajobs:latest .

# Login ke GitHub Packages
echo $CR_PAT | docker login ghcr.io -u hijazp --password-stdin

# Mengunggah image ke Github Packages
docker push ghcr.io/hijazp/karsajobs:latest