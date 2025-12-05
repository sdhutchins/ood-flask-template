#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

module load Python
python -m virtualenv venv
source venv/bin/activate
pip install -r requirements.txt

# Create bin directory if it doesn't exist
mkdir -p bin
# Create symlink to python in venv
ln -sf ../venv/bin/python bin/python