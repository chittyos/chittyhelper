# 🟦 ChittyHelper — Canonical Design Specification (v1.0)

**System Class:** III — Directional Architecture Navigator
**Phase:** Design-Only
**Status:** FROZEN / HAND-OFF
**Purpose:** Provide deterministic, non-authoritative orientation about where architectural responsibilities already exist inside the Chitty ecosystem.

---

## 1  System Definition

> **ChittyHelper** is a read-only, stateless navigation surface that answers directional architecture questions such as:
> *Is this capability already defined?*  *Which canonical system owns this?*  *Does this design duplicate something?*  *Where do I connect?*

ChittyHelper **does not** execute, validate, summarize, or decide.

---

## 2  Scope and Boundaries

| Dimension | In-Scope              | Out-of-Scope                |
| --------- | --------------------- | --------------------------- |
| Function  | Orientation / mapping | Evaluation / recommendation |
| Access    | Read-only             | Mutations, orchestration    |
| Trust     | Non-authoritative     | Signing, validation         |
| State     | Ephemeral             | Persistence, caching        |
| Secrets   | None held             | Any credential storage      |

Disabling ChittyHelper has no impact on canonical systems.

---

## 3  Canonical Context

| Canonical Layer          | Function                  | Helper Role      |
| ------------------------ | ------------------------- | ---------------- |
| **ChittyCanon**          | Architectural definitions | Reference only   |
| **ChittyID**             | Identity & authority      | Name lookup      |
| **ChittyCert**           | Trust & signing           | Reference only   |
| **ChittyChain / Ledger** | Proof & audit             | Reference only   |
| **ChittyConnect**        | Access & delegation       | Connection index |
| **MCP / Agents**         | Execution                 | None             |

Helper never substitutes or emulates these systems.

---

## 4  Permitted Intent Classes

| Code        | Description               | Typical Question Form              |
| ----------- | ------------------------- | ---------------------------------- |
| **I_EXIST** | Existence / definition    | “Is this architecturally defined?” |
| **I_OWN**   | Ownership / placement     | “Where does this live?”            |
| **I_DUP**   | Duplication / parallelism | “Is this duplicating X?”           |
| **I_DIR**   | Direction / connection    | “Where do I connect to X?”         |

Any request outside these intents is refused.

---

## 5  State Machine Summary

```
S0 Idle
 → S1 Ingest
 → S2 Classify
 → S3 Validate
     ├─ allowed → S4 Resolve → S5 Assemble → S6 Envelope → S8 Emit
     └─ out-of-scope → S7 Refuse
```

Terminal states: S7 (Refusal) and S8 (Response Emitted).
No persistent state across invocations.

---

## 6  Uncertainty Enumeration

```
DefinitionState = { DEFINED, UNDEFINED, IMPLICIT, DISTRIBUTED, CONTESTED }
```

Exactly one value appears per response.

---

## 7  Response Schema (JSON)

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

Refusal form:

```json
{
  "system": "chittyhelper",
  "response_type": "refusal",
  "reason": "out_of_scope",
  "snapshot_time": "2025-12-23T00:00:00Z"
}
```

All fields are mandatory; no additional properties allowed.

---

## 8  Registry Data Model (Index-Only)

| Field             | Type     | Description                     |
| ----------------- | -------- | ------------------------------- |
| `system_id`       | string   | Canonical unique identifier     |
| `ownership_scope` | string   | Responsibility domain           |
| `doc_ref`         | uri      | Canonical documentation link    |
| `interface_ref`   | uri      | Connection endpoint             |
| `last_verified`   | datetime | Registry verification timestamp |

Registry is immutable and read-only.

---

## 9  Determinism and Invariants

1. **Identical inputs → identical outputs.**
2. **Each response single-sentence and present-tense.**
3. **No modal verbs or evaluative adjectives.**
4. **Envelope integrity non-mutable after injection.**
5. **No cross-request memory or context carryover.**

---

## 10  Governance Classification Matrix

| Class   | Authority Level         | Example       |
| ------- | ----------------------- | ------------- |
| **I**   | Canonical control       | ChittyChain   |
| **II**  | Operational subsystem   | ChittyConnect |
| **III** | Informational navigator | ChittyHelper  |

ChittyHelper remains Class III until re-chartered.

---

## 11  Interfaces

| Route                      | Method | Description                       | Output               |
| -------------------------- | ------ | --------------------------------- | -------------------- |
| `/api/helper/query`        | POST   | Accepts query body (text or JSON) | ChittyHelperResponse |
| `/api/helper/registry/:id` | GET    | Returns index-only metadata       | Registry record      |
| `/api/helper/ping`         | GET    | Health indicator                  | `{"status":"ok"}`    |

All routes are **side-effect-free**.

---

## 12  Invariants (Structural)

1. No execution or policy statements.
2. Every response contains `authoritative:false`.
3. Helper outputs are read-only facts, not directives.
4. Helper cannot alter or create canonical entries.
5. Disablement is instant and non-cascading.

---

## 13  Governance Artifacts to Accompany Design

| Document                          | Purpose                            |
| --------------------------------- | ---------------------------------- |
| **Architecture Specification**    | Core design record (this document) |
| **Definitions Addendum**          | Formal terminology and semantics   |
| **State Machine Specification**   | Behavioral sequence                |
| **Intent & Schema Specification** | Data and linguistic constraints    |
| **Governance Matrix**             | System class roles                 |
| **Registry Model**                | Canonical index layout             |

Together these form the complete audit baseline.

---

## 14  Canonical Statement of Purpose

> **`@ChittyHelper`** is a deterministic, stateless, non-authoritative architectural navigation layer that maps ideas and proposals to existing Chitty canonical systems, exposing duplication and parallel-system risk while never issuing decisions, recommendations, or validations.

---

### 📘 End of Design Package — Ready for Independent Audit

This is the final consolidated specification of **ChittyHelper v1.0**.
No further modification occurs within the design phase.

