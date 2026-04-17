# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Safety Constraints (Non-Negotiable)

These apply to all agents and the main assistant, always. **If any constraint blocks progress:** stop and ask a clarifying question, ask for explicit confirmation to bypass, or offer a safe alternative.

### Git & Deployment
1. **No commits or pushes without explicit user consent.** Never run `git commit`, `git push`, or any variant without the user directly asking for it in that message.
2. **No changes on `main` branch.** Before writing any code, check the current branch. If on `main`, stop and ask the user to switch or create a branch first.

### Database
3. **No destructive database actions.** Never run `DROP`, `TRUNCATE`, unscoped `DELETE`, or irreversible migrations without explicit user confirmation. Always write reversible migrations.

### Production
4. **No access to production infrastructure or data.** Never connect to production databases, read production credentials, SSH into production servers, or trigger production deploys.

### Secrets & Sensitive Data
5. **Never commit or expose secrets.** Treat as sensitive: `.env*`, `credentials.*`, `config/master.key`, API keys, tokens, private keys, cookies, session dumps, vendor dashboard exports, and customer PII (names, emails, phone numbers, addresses, documents). Never paste secrets into git history, PR descriptions, commit messages, screenshots, logs, or test fixtures. Never hardcode credentials in any file.
6. **Adding or changing a secret:** ask first, then use existing repo mechanisms (Rails credentials, CI secrets).

### Dependencies
7. **Dependency changes require explicit approval.** Do not add, remove, or upgrade anything in `Gemfile`, `Gemfile.lock`, `package.json`, or `yarn.lock` without asking. Explain why, list the exact files/versions that would change, and wait for confirmation.

### Configuration
8. **Project config changes require explicit approval.** Do not modify `config/**/*`, `Procfile*`, `Dockerfile*`, CI configs (`.github/**`), build tooling, linters/formatters, database config, or nginx config without asking. Propose the minimal change and its impact, then wait for confirmation.

### Machine & OS
9. **Never modify the developer machine or OS.** Do not run `apt`, `brew`, modify system services, `/etc/*`, shell rc files, global git config, ssh config, or kernel/network settings. If setup steps are needed, provide instructions for the user to run manually.

---

## Overview

This project is a Rails 8 monolithic application ("Majestic Monolith") for event management and e-commerce. Ruby 3.4.4, MySQL, Solid Trifecta. Frontend uses Hotwired (Turbo + Stimulus), esbuild and Tailwind.

## Common Commands

```bash
# Development
bin/dev              # Start server with CSS/JS watchers (Puma on :3000)
bin/debug            # Start server without asset watchers

# Testing
bin/rails test                                    # Run all tests
bin/rails test test/models/account_test.rb        # Single file
bin/rails test test/models/account_test.rb:25     # Single test by line
bin/rails test test/system/checkouts              # Directory

# Linting & Security
bin/rubocop          # Lint (Rails Omakase style)
bin/brakeman         # Security scan

# Assets
rake assets:precompile           # Compile assets production
```

## Architecture

### App Structure

- **`app/assets/`** — JavaScript (esbuild), stylesheets (Dart Sass), images
- **`app/controllers/`** — Organized by domain: `admin/`, `api/`, `accounts/`, `auth/`, `checkouts/`, `companies/`
- **`app/forms/`** — Form objects for complex input handling
- **`app/helpers/`** — View helpers
- **`app/jobs/`** — Sidekiq background jobs
- **`app/lib/`** — Custom library modules
- **`app/mailers/`** — Action Mailers for email notifications
- **`app/models/`** — ActiveRecord models
- **`app/presenters/`** — View presenters
- **`app/services/`** — External integrations organized by partners (magalu, digipix, intercom...)
- **`app/views/`** — ERB templates organized by controller

### Testing

- Minitest with Capybara + Selenium (headless Chrome) for system tests
- Tests run in parallel by default (workers = CPU count / 2)
- Fixtures in `test/fixtures/`

### Third-party Integrations

- AI: Anthropic.

### Database

- MySQL.
- Timezone: `America/Sao_Paulo`.
- Credentials via Rails encrypted credentials (`config/credentials/`).
