# Registry (Index-Only)

Immutable, read-only index of canonical nodes referenced by ChittyHelper.

Data model fields:
- `system_id` (string)
- `ownership_scope` (string)
- `doc_ref` (uri)
- `interface_ref` (uri)
- `last_verified` (datetime)

No secrets or credentials are stored here. No writes occur.

