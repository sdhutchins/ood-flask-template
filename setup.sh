#!/bin/bash
set -eo pipefail
IFS=$'\n\t'

module load Python
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Create bin directory if it doesn't exist
mkdir -p bin

# Remove existing bin/python if it exists (symlink or file)
rm -f bin/python

# Create Python wrapper script (matches OSC example pattern)
cat > bin/python << 'EOF'
#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
APP_DIR=$( cd -- "$SCRIPT_DIR/.." &> /dev/null && pwd )

# Load Python module to set up library paths
#module load Python 2>/dev/null || true

# Activate venv (venv is in app root directory)
source "$APP_DIR/venv/bin/activate"

exec python "$@"
EOF

# Make it executable
chmod +x bin/python