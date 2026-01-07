# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

**ChittyHelper** is a Class III informational service within the ChittyOS ecosystem - a deterministic, stateless, non-authoritative architectural navigation layer that helps answer directional architecture questions.

**Purpose:** ChittyHelper provides read-only orientation about where architectural responsibilities exist in the Chitty ecosystem without executing, validating, or making decisions.

**Key Questions ChittyHelper Answers:**
- Is this capability already defined?
- Which canonical system owns this?
- Does this design duplicate something?
- Where do I connect?

## Repository Structure

```
chittyhelper/
├── docs/                         # Design specifications
│   ├── ChittyHelper-Canonical-Design-Spec-v1.0.md  # Primary spec
│   ├── REGISTRATION.md           # Service registration guide
│   ├── Validation-Summary.md     # Validation documentation
│   └── openapi.yaml              # OpenAPI specification
├── data/                         # Static data artifacts
│   ├── intents/                  # Intent classification vocabulary
│   │   ├── manifest.json         # Supported intents (I_EXIST, I_OWN, I_DUP, I_DIR)
│   │   └── README.md
│   └── schemas/                  # JSON Schema definitions
│       ├── response.schema.json  # Response envelope schema
│       ├── registry.record.schema.json  # Registry record schema
│       └── examples/             # Example responses
├── scripts/                      # Automation scripts
│   ├── register.sh               # Registration script for register.chitty.cc
│   ├── registration.json         # ChittyHelper's registration payload
│   └── ci/                       # CI/CD scripts
├── customgpt/                    # ChatGPT Custom GPT integration
│   ├── chittyhelper-actions.json # OpenAPI spec for Custom GPT Actions
│   └── README.md
└── .github/                      # GitHub configuration
    └── pull_request_template.md
```

**Note:** Service registry lookups use registry.chitty.cc - no local registry cache maintained.

## Core Architecture Principles

### System Classification

ChittyHelper is **Class III** in the ChittyOS governance hierarchy:

| Class | Authority Level         | Example       |
|-------|-------------------------|---------------|
| I     | Canonical control       | ChittyChain   |
| II    | Operational subsystem   | ChittyConnect |
| III   | Informational navigator | ChittyHelper  |

### Invariant Properties

All ChittyHelper responses MUST maintain these invariants:

1. **Non-authoritative** - `authoritative: false` in all responses
2. **Not decision-safe** - `decision_safe: false` in all responses
3. **Read-only** - All endpoints are side-effect-free
4. **Stateless** - No persistent state across invocations
5. **Deterministic** - Identical inputs produce identical outputs
6. **Single-sentence responses** - Present-tense, no modal verbs

### Supported Intent Classes

ChittyHelper only handles four intent types:

- **I_EXIST** - Existence/definition queries ("Is this architecturally defined?")
- **I_OWN** - Ownership/placement queries ("Where does this live?")
- **I_DUP** - Duplication/parallelism queries ("Is this duplicating X?")
- **I_DIR** - Direction/connection queries ("Where do I connect to X?")

Any request outside these intents MUST be refused.

### Definition States

Every response includes one of these definition states:

- `DEFINED` - Capability exists in canonical architecture
- `UNDEFINED` - Not yet architecturally defined
- `IMPLICIT` - Implied but not explicitly documented
- `DISTRIBUTED` - Spread across multiple systems
- `CONTESTED` - Multiple overlapping definitions exist

## Response Schema

### Directional Response

```json
{
  "system": "chittyhelper",
  "system_class": "directional_architecture_navigator",
  "authoritative": false,
  "decision_safe": false,
  "response_type": "directional",
  "intent": "I_EXIST",
  "definition_state": "DEFINED",
  "statement": "This capability is defined in ChittyCanon under core.services.identity.",
  "sources": ["chittycanon://core/services/identity"],
  "snapshot_time": "2025-12-23T00:00:00Z"
}
```

### Refusal Response

```json
{
  "system": "chittyhelper",
  "response_type": "refusal",
  "reason": "out_of_scope",
  "snapshot_time": "2025-12-23T00:00:00Z"
}
```

All fields are mandatory; no additional properties allowed.

## Service Endpoints

| Route                      | Method | Purpose                       | Read-Only |
|----------------------------|--------|-------------------------------|-----------|
| `/api/helper/ping`         | GET    | Health indicator              | ✓         |
| `/api/helper/query`        | POST   | Query architectural questions | ✓         |
| `/api/helper/registry/:id` | GET    | Retrieve registry metadata    | ✓         |

## Registry Integration

ChittyHelper uses **registry.chitty.cc** for service discovery - no local registry cache is maintained.

**Registry Record Schema:** See `data/schemas/registry.record.schema.json` for the data model.

**Required Fields:**
- `system_id` - Canonical unique identifier
- `ownership_scope` - Responsibility domain
- `doc_ref` - Canonical documentation URI
- `interface_ref` - Connection endpoint URI
- `last_verified` - Registry verification timestamp

## Service Registration

ChittyHelper is registered through ChittyRegister using the standard ChittyOS registration flow.

### Registration Process

1. **Obtain credentials**: Get `CHITTY_REGISTER_TOKEN` from `get.chitty.cc`
2. **Submit registration**: Run the registration script
3. **Verify compliance**: Check registration status

```bash
# Set registration token
export CHITTY_REGISTER_TOKEN="<token from get.chitty.cc>"

# Submit registration (default: register.chitty.cc)
./scripts/register.sh

# Or use Workers fallback
./scripts/register.sh chittyregister-production.chitty.workers.dev

# Check compliance status
curl -sS https://register.chitty.cc/api/v1/compliance/chittyhelper | jq .
```

## Custom GPT Integration

The `customgpt/` directory contains a self-contained OpenAPI specification for integrating ChittyHelper into ChatGPT Custom GPT Actions.

**Import Steps:**
1. In ChatGPT, create/edit your GPT → Configure → Actions → Add new action
2. Import `customgpt/chittyhelper-actions.json` (or YAML variant)
3. Update server URL to deployed ChittyHelper host
4. Save configuration

## Development Guidelines

### Schema Validation

All responses must validate against `data/schemas/response.schema.json`:

- Use JSON Schema Draft 2020-12
- Enforce `additionalProperties: false`
- All required fields must be present
- Enums must match exactly (case-sensitive)

### Documentation Standards

- Design specifications are frozen/hand-off status
- All documentation uses present-tense, declarative statements
- No modal verbs ("should", "could", "would") in specifications
- Single-sentence statements with no line breaks

## Integration with ChittyOS Ecosystem

ChittyHelper references but never substitutes these canonical systems:

| System          | Function               | Helper's Role   |
|-----------------|------------------------|-----------------|
| ChittyCanon     | Architectural defs     | Reference only  |
| ChittyID        | Identity & authority   | Name lookup     |
| ChittyCert      | Trust & signing        | Reference only  |
| ChittyChain     | Proof & audit          | Reference only  |
| ChittyConnect   | Access & delegation    | Connection index|
| ChittyRegistry  | Service discovery      | Index consumer  |
| ChittyRegister  | Service onboarding     | Registration    |

## Critical Constraints

1. **Never execute or validate** - ChittyHelper only provides directional information
2. **Never make decisions** - Responses guide but do not decide
3. **Never store state** - No persistence, caching, or session management
4. **Never hold secrets** - No credentials or tokens stored
5. **Never mutate canonical systems** - Read-only access to all references
6. **Always refuse out-of-scope requests** - Strict intent classification
7. **Always include snapshot_time** - All responses timestamped

## State Machine Flow

```
S0 Idle
 → S1 Ingest (receive query)
 → S2 Classify (determine intent)
 → S3 Validate (check scope)
     ├─ allowed → S4 Resolve → S5 Assemble → S6 Envelope → S8 Emit
     └─ out-of-scope → S7 Refuse
```

Terminal states: S7 (Refusal) and S8 (Response Emitted).

## Common Patterns

### Registering ChittyHelper

Use the registration script to register with ChittyRegister:

```bash
export CHITTY_REGISTER_TOKEN="<token from get.chitty.cc>"
./scripts/register.sh
```

Registration payload is in `scripts/registration.json`.

### Testing Response Formats

Example responses are in `data/schemas/examples/`:
- `directional-response.example.json`
- `refusal-response.example.json`
- `registry-record.example.json`

Use these as templates for validation testing.

### Updating Documentation

1. All docs in `docs/` are design artifacts
2. Canonical spec is frozen (v1.0)
3. Operational docs can be updated
4. Follow declarative, present-tense style

## Pull Request Guidelines

When submitting PRs, use the template checklist:

- [ ] Tests added/updated (if applicable)
- [ ] Documentation updated (if applicable)
- [ ] No secrets or tokens committed

AI review bots configured via `.coderabbit.yml`:
- CodeRabbit: @coderabbitai
- Focus areas: security, correctness, performance, maintainability
