#!/usr/bin/env bash
set -euo pipefail
pytest -q
docker build -t campus-tasks:check .
echo "projet OK"
