# ChittyHelper Navigation

Quick reference for navigating the ChittyHelper repository.

## Start Here

1. **[CLAUDE.md](./CLAUDE.md)** - Main guidance for working with this repository
2. **[Design Spec](./chittyfoundation/helper/docs/ChittyHelper-Canonical-Design-Spec-v1.0.md)** - Canonical design specification v1.0
3. **[Registration Guide](./chittyfoundation/helper/docs/REGISTRATION.md)** - Service registration instructions

## Core Documentation

### Design & Architecture
- [Canonical Design Spec v1.0](./chittyfoundation/helper/docs/ChittyHelper-Canonical-Design-Spec-v1.0.md) - Frozen specification
- [Validation Summary](./chittyfoundation/helper/docs/Validation-Summary.md) - Validation documentation
- [AI Code Review](./chittyfoundation/helper/docs/AI_CODE_REVIEW.md) - Review guidelines

### Intent & Classification
- [Intent Manifest](./chittyfoundation/helper/intent/manifest.json) - Supported intents (I_EXIST, I_OWN, I_DUP, I_DIR)
- [Intent README](./chittyfoundation/helper/intent/README.md) - Intent vocabulary

## Registry (Read-Only Index)

### Registry Files
- [Registry Index](./chittyfoundation/helper/registry/index.json) - Master index
- [Self Registration](./chittyfoundation/helper/registry/self.json) - ChittyHelper's own record
- [Registry README](./chittyfoundation/helper/registry/README.md) - Data model documentation

### Core Service Records
- [ChittyID](./chittyfoundation/helper/registry/chittyid.json)
- [ChittyAuth](./chittyfoundation/helper/registry/chittyauth.json)
- [ChittyRegister](./chittyfoundation/helper/registry/chittyregister.json)
- [ChittyRegistry](./chittyfoundation/helper/registry/chittyregistry.json)
- [ChittyConnect](./chittyfoundation/helper/registry/chittyconnect.json)
- [ChittyVerify](./chittyfoundation/helper/registry/chittyverify.json)
- [ChittyChain](./chittyfoundation/helper/registry/chittychain.json)
- [ChittyCert](./chittyfoundation/helper/registry/chittycert.json)
- [ChittyTrust](./chittyfoundation/helper/registry/chittytrust.json)
- [ChittyCanon](./chittyfoundation/helper/registry/chittycanon.json)
- [ChittyEvidence](./chittyfoundation/helper/registry/chittyevidence.json)

## Schemas & Examples

### JSON Schemas
- [Response Schema](./chittyfoundation/helper/schema/response.schema.json) - ChittyHelperResponse (directional + refusal)
- [Registry Record Schema](./chittyfoundation/helper/schema/registry.record.schema.json) - Registry data model

### Example Responses
- [Directional Response](./chittyfoundation/helper/schema/examples/directional-response.example.json)
- [Refusal Response](./chittyfoundation/helper/schema/examples/refusal-response.example.json)
- [Registry Record](./chittyfoundation/helper/schema/examples/registry-record.example.json)

## Custom GPT Integration

- [Actions Spec (JSON)](./customgpt/chittyhelper-actions.json) - OpenAPI 3.1 specification for ChatGPT
- [Integration README](./customgpt/README.md) - Import instructions

## Service Registration

### Registration Files
- [Registration Payload](./chittyfoundation/helper/registry/chittyhelper.registration.json) - Service registration JSON
- [Registration Script](./chittyfoundation/helper/registry/register-chittyhelper.sh) - Automated registration

### Registration Workflow

```bash
# 1. Obtain token from onboarding portal
# Get CHITTY_REGISTER_TOKEN at get.chitty.cc

# 2. Submit registration
export CHITTY_REGISTER_TOKEN="<your-token>"
./chittyfoundation/helper/registry/register-chittyhelper.sh

# 3. Check compliance status
curl -sS https://register.chitty.cc/api/v1/compliance/chittyhelper | jq .
```

## Configuration Files

- [CodeRabbit Config](./.coderabbit.yml) - AI review bot configuration
- [PR Template](./.github/pull_request_template.md) - Pull request checklist

## Key Concepts

### System Classification
- **Class:** III - Informational Navigator
- **Authority:** Non-authoritative
- **State:** Stateless, ephemeral
- **Access:** Read-only

### Supported Intents
- **I_EXIST** - "Is this architecturally defined?"
- **I_OWN** - "Where does this live?"
- **I_DUP** - "Is this duplicating X?"
- **I_DIR** - "Where do I connect to X?"

### Definition States
- `DEFINED` - Exists in canonical architecture
- `UNDEFINED` - Not yet defined
- `IMPLICIT` - Implied but not explicit
- `DISTRIBUTED` - Spread across multiple systems
- `CONTESTED` - Multiple overlapping definitions

## API Endpoints

All endpoints are read-only and side-effect-free:

| Route                      | Method | Purpose                       |
|----------------------------|--------|-------------------------------|
| `/api/helper/ping`         | GET    | Health indicator              |
| `/api/helper/query`        | POST   | Query architectural questions |
| `/api/helper/registry/:id` | GET    | Retrieve registry metadata    |

## ChittyOS Ecosystem Links

### Related Services
- ChittyID: https://id.chitty.cc
- ChittyAuth: https://auth.chitty.cc
- ChittyRegister: https://register.chitty.cc
- ChittyRegistry: https://registry.chitty.cc
- ChittyConnect: https://connect.chitty.cc

### GitHub Organizations
- ChittyFoundation: https://github.com/chittyfoundation
- ChittyOS: https://github.com/chittyos

### Service Onboarding
- Get Started: https://get.chitty.cc

---

**Remember:** ChittyHelper is Class III informational - read-only, stateless, non-authoritative architectural navigation.
