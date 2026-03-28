# AGENTS.md

Agent instructions for the `blog-coringao` Rails application.

---

## Stack

- Ruby 3.4.4
- Rails 8.2.0.alpha
- MySQL (Rails native adapter)
- Solid Cache, Solid Queue, Solid Cable
- Minitest < 6
- Stimulus (JavaScript)
- Sprockets (assets)

---

## Mandatory Pre-Task Checks

1. **Check current branch.** Never code on `main`. If on `main`, ask the user to create a feature branch before proceeding.
2. **Never commit anything** unless explicitly asked.
3. **Read memory files** before starting:
   - Always: `.opencode/memory/preferences.md`
   - If coding: `.opencode/memory/patterns.md`
   - If architecting: `.opencode/memory/decisions.md`

---

## Commands

| Purpose | Command |
|---|---|
| Run app locally | `./bin/dev` (NOT `./bin/debug`) |
| Lint + auto-correct | `bin/rubocop -A` |
| Verify assets compile | `rake assets:precompile` |
| Run all tests | `bin/rails test` |
| Run a single test file | `bin/rails test test/path/to/file_test.rb` |
| Run a single test by line | `bin/rails test test/path/to/file_test.rb:42` |
| Run a single test by name | `bin/rails test -n test_method_name` |

**Before finishing any task that touched code:** run `bin/rubocop -A`.  
**Before finishing any task that touched assets:** run `rake assets:precompile`.

---

## Project Constraints (Non-Negotiable)

### Secrets
- Never commit secrets, credentials, API keys, tokens, PII, or session data.
- Sensitive files: `.env*`, `credentials.*`, `config/master.key`, vendor exports.
- Always use `Rails.application.credentials` — never hardcode tokens or URLs.
- Do not paste secrets into git history, commit messages, PR descriptions, logs, or fixtures.

### Dependencies
- Do not add or upgrade gems/packages without explicit user approval.
- Explain why a new dependency is needed, list exact files/versions, then wait for confirmation.

### Configuration
- Do not change `config/**`, `Procfile*`, `Dockerfile*`, CI configs, linters, or database config without approval.
- Propose the minimal change and its impact, then wait for confirmation.

### OS/Machine
- Never modify OS or developer machine settings (apt, brew, shell rc files, global git config, etc.).
- Provide manual instructions for the user to run instead.

---

## Code Style

### General
- **No comments in code.** Code must be self-documenting.
- Small, single-responsibility methods — no large methods with multiple responsibilities.
- Logic belongs in controllers/helpers, not directly in views.
- Views must be concise; use partials to organize sections.

### Naming Conventions
- **Concerns:** capability nouns (`Cacheable`, `Variantable`, `Interactee`) or trait phrases (`OriginatesFromDomain`).
- **Jobs:** `{Domain}::{Action}Job` — e.g., `Invitation::MarkAsPaidJob`, `Imager::DetectPrimaryColorJob`.
- **Service vendors:** `app/services/{vendor}/` — e.g., `pagarme/`, `vtex/`, `anymarket/`.

### Architecture
- **Domain logic in models/concerns** — not in service objects.
- **Service objects only for external API integrations** (`app/services/{vendor}/`).
- **Form objects** (`app/forms/`) when a form touches multiple models, needs a single validation surface, or spans conditional validations. Must: validate, persist in a transaction, return success/failure.
- **Background jobs** (`app/jobs/{domain}/`): keep jobs thin — they call model methods. Use `after_commit` for state-dependent async work.

### ActiveRecord
- Use `ActiveRecord::Base.transaction` to wrap multi-record changes.
- Never use `update_column` or `update_all` (skips validations/callbacks).
- N+1 prevention: `.includes` for associations used in views, `.preload` when not querying further, `.eager_load` when filtering by association.
- Scopes: composable, express intent.
- Always `order(:id)` before `.first`/`.last` to guarantee deterministic results.

### Callbacks
- Only for persistence side effects; keep them small.

---

## Backend: External Integrations

Structure under `app/services/{vendor}/`:

```
app/services/pagarme/
├── client.rb              # HTTP setup + auth
├── api/
│   ├── payment.rb         # Endpoint wrappers
│   └── order.rb
├── adapter/
│   └── payment/
│       └── postback.rb    # Payload mapping
└── service/               # High-level workflows (optional)
```

- Set both open and read timeouts on HTTP clients.
- Retry only if the API is idempotent; prefer background jobs for retry/backoff.
- Dedicated error class per vendor (e.g., `Vtex::ApiError`) with context: endpoint, HTTP status, body snippet.
- Never log secrets or PII in error context.

---

## Frontend

### Layout & Grid
- Grid: `grid`, `cell-col-*`, `cell-row-*`; desktop prefix `d-` (e.g., `d-cell-col-12`, `d-mt-32`).
- Spacing in multiples of 8: `m-8`, `mt-16`, `mb-24`, `mx-*`, `p-*`.
- Responsive: some pages use `file.html.erb` + `file.html+desktop.erb` dual-template pattern.

### Typography & Color
- `txt-font-primary` (NOT `txt-sans-serif`), `txt-bold`, `txt-16`, `uppercase`.
- Colors: `txt-primary`, `bg-gray-24`, `bg-success`.
- Reference: `app/views/admin/design_systems/guidelines/`.

### Components
- Buttons: `btn`, `btn-primary`, `btn-transparent`.
- Forms: use helpers (`fudgeball_input`, `fudgeball_select_input`, `fudgeball_return_to`) — don't hand-roll.
- Find existing patterns in `app/views/admin/design_systems/{forms,elements}/` before building new ones.

### CSS Priority
1. Utility classes (preferred)
2. Inline styles (acceptable if not reused)
3. Style tag in partial (for complex, scoped styles)

When adding CSS: create a partial, add it to the view (not to other partials), scope selectors (`#section-name .class`), avoid `!important` unless matching an existing pattern.

### JavaScript
- Prefer Stimulus with `data-action` / `data-target` attributes.
- Check `app/assets/javascript/controllers/fudgeball/util_controller.js` before writing new controllers.
- Pages must be usable without JS where feasible (progressive enhancement).
- No new JS dependencies.

### Accessibility
- All form inputs need accessible labels (visible or `aria-label`).
- Visible validation feedback required.
- No horizontal scroll at small widths; avoid fixed widths.
- Images require alt text.

---

## Testing

- Framework: Minitest + fixtures (Minitest < 6).
- Avoid creating new fixtures.
- System tests: explain why one is needed and ask permission before adding.
- Stub external calls at the client boundary by default; ask before making real HTTP requests.
- Always `order(:id)` before `.first`/`.last` in tests.
- Only run tests when explicitly requested or when a task requires verification.

---

## Skills System

Load task-specific skills via the `skill` tool:

| Task type | Skill |
|---|---|
| Backend / models / jobs / integrations | `skill name: backend` |
| Frontend / UI / CSS / Stimulus | `skill name: frontend` |
| Tests / fixtures | `skill name: tests` |

---

## Memory System

Append learnings to `.opencode/memory/daily/{today}.md` during the session (don't wait until the end):

- User preference stated → "Code Preferences Identified"
- User corrected behavior → "Corrections Given"
- Pattern used 3+ times → "Patterns Used"
- Architectural decision made → "Decisions Made"
- Mistake avoided → "Pitfalls Avoided"

Use `_template.md` if today's file doesn't exist yet. One line per item, actionable format.
