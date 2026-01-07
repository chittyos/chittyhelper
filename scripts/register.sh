#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   1) Obtain CHITTY_REGISTER_TOKEN at get.chitty.cc (onboarding portal)
#   2) CHITTY_REGISTER_TOKEN=... ./scripts/register.sh [host]
#
# host defaults to register.chitty.cc; fallback to workers.dev supported.

HOST="${1:-register.chitty.cc}"
PAYLOAD_FILE="$(dirname "$0")/registration.json"

if [ -z "${CHITTY_REGISTER_TOKEN:-}" ]; then
  echo "CHITTY_REGISTER_TOKEN is required (export it first)" >&2
  exit 1
fi

echo "Submitting registration to https://${HOST}/api/v1/register ..."
set -x
curl -sS -X POST "https://${HOST}/api/v1/register" \
  -H "Authorization: Bearer ${CHITTY_REGISTER_TOKEN}" \
  -H 'Content-Type: application/json' \
  --data-binary "@${PAYLOAD_FILE}" | sed -n '1,200p'

echo
echo "Fetching requirements (preflight):"
set -x
curl -sS "https://${HOST}/api/v1/requirements" | sed -n '1,200p'

echo
echo "Query compliance status:"
set -x
curl -sS "https://${HOST}/api/v1/compliance/chittyhelper" | sed -n '1,200p'
