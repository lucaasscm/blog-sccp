---
name: backend
description: Backend Rails development standards - models, services, jobs, external integrations
---

# Backend Standards

**Read first:** 
- `.opencode/memory/preferences.md` for naming and communication style
- `.opencode/db/minimal_schema.md` for database structure when needs to understand relations (use grep to search specific tables/associations, avoid reading entire file)

Domain logic in models/concerns. External APIs in `app/services/**`. No service-object sprawl.

## Before Coding

Check existing patterns:
- Concerns: `app/models/concerns/` (capability names: `Cacheable`, `Variantable`, `Interactee`)
- Services: `app/services/{vendor}/` (structure: Client, Api::*, Adapter::*)
- Jobs: `app/jobs/{domain}/` (e.g., `Invitation::MarkAsPaidJob`)

## Domain Logic

**Models & Concerns:**
- Business rules in models/concerns
- Concern naming: capabilities (`Cacheable`) or traits (`OriginatesFromDomain`)
- Shared: `app/models/concerns/*.rb`
- Specific: model namespace (e.g., `app/models/order/fulfiller.rb`)
- Callbacks: only for persistence side effects, keep small

**Transactions:**
- DB constraints for invariants (unique indexes, not-null, FK)
- Wrap multi-record changes: `ActiveRecord::Base.transaction`
- Avoid `update_column`/`update_all` (skips validations/callbacks)

**N+1 Prevention:**
- `.includes` for associations used in views
- `.preload` when associations won't be queried further
- `.eager_load` when filtering by association
- Scopes: composable, express intent

**Form Objects:**
Use `app/forms/**` when:
- Touches multiple models
- Needs single validation surface
- Conditional validations spanning models

Must: validate, persist in transaction, return success/failure

## External Integrations

**Structure (`app/services/{vendor}/`):**
Real examples: `pagarme/`, `vtex/`, `anymarket/`

```
app/services/pagarme/
├── client.rb              # HTTP/auth
├── api/
│   ├── payment.rb         # Endpoints
│   └── order.rb
├── adapter/
│   └── payment/
│       └── postback.rb    # Payload mapping
└── service/               # High-level workflows (optional)
```

**Reliability:**
- Set timeouts (open + read)
- Retry only if API is idempotent
- Prefer background jobs for retry/backoff

**Errors:**
- Dedicated error class (e.g., `Vtex::ApiError`)
- Include context (endpoint, status, body snippet)
- Never log secrets/PII

**Credentials:**
- Use `Rails.application.credentials`
- Never hardcode tokens/URLs

## Background Jobs

**Naming:** `{Domain}::{Action}Job`
Real examples:
- `Invitation::MarkAsPaidJob`
- `Invitation::SendInvitationWazzapJob`
- `Imager::DetectPrimaryColorJob`

**Pattern:**
- Jobs call methods (keep jobs thin)
- Re-enqueue with backoff: `set(wait: backoff)`
- Use `after_commit` for state-dependent work

## Tests

- Minitest + fixtures
- Avoid new fixtures
- Order by `:id` before `.first`/`.last`
- Integrations: stub at client boundary, ask before real HTTP

## Delivery

- [ ] Domain logic in models/concerns (NOT services)
- [ ] Integration timeouts + error handling
- [ ] Async work via `after_commit`
- [ ] Tests updated
- [ ] `bin/rubocop -A` passes
