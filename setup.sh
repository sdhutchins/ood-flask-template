#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

module load Python
python -m virtualenv .venv
source .venv/bin/activate
pip install -r requirements.txt
