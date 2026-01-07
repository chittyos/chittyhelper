# ChittyHelper Registration (Through ChittyRegister)

This documents the canonical registration path, starting at `get.chitty.cc`.

- Start: `get.chitty.cc` — obtain client credentials (CHITTY_REGISTER_TOKEN) and onboarding instructions.
- Register: `register.chitty.cc` — submit the service payload to `/api/v1/register`.
- Verify: query compliance and bindings; publication proceeds to Registry and Discovery.

## Prerequisites
- CHITTY_REGISTER_TOKEN (from get.chitty.cc)
- Payload file: `chittyfoundation/helper/registry/chittyhelper.registration.json`

## Submit Registration

```bash
export CHITTY_REGISTER_TOKEN="<your token from get.chitty.cc>"
# Production host
chittyfoundation/helper/registry/register-chittyhelper.sh
# Workers fallback (if DNS not available locally)
chittyfoundation/helper/registry/register-chittyhelper.sh chittyregister-production.chitty.workers.dev
```

## Check Compliance

```bash
curl -sS https://register.chitty.cc/api/v1/compliance/chittyhelper | jq .
```

Notes:
- ChittyRegister validates required fields and may mint a ChittyID and certificate before binding to Registry and Discovery.
- ChittyHelper remains Class III (informational); endpoints are read-only.

