# Custom GPT Actions — ChittyHelper

This folder contains a self-contained OpenAPI specification (YAML and JSON) for importing ChittyHelper Actions into Custom GPTs (ChatGPT “Actions”).

Import steps
- In ChatGPT, create/edit your GPT → Configure → Actions → Add new action → Import OpenAPI file.
- Choose `customgpt/chittyhelper-actions.yaml` (or JSON variant).
- Update the server URL to the deployed ChittyHelper host before saving.

Notes
- ChittyHelper is Class‑III informational and read‑only; no secrets or writes.
- The schema is self‑contained and avoids external $ref links for easier ingestion.
- Default server is a placeholder; replace with your production host.

