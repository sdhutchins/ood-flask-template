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

# Create Python wrapper script (activates venv before running Python)
cat > bin/python << 'EOF'
#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/../venv/bin/activate

exec /usr/bin/env python3 "$@"
EOF

# Make it executable
chmod +x bin/python