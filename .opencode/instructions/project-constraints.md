# Project Constraints (Skill)

This skill defines non-negotiable safety constraints for working in this repo.

## Secrets and sensitive data

- Never commit secrets or credentials.
- Treat as sensitive:
  - `.env*`, `credentials.*`, `config/master.key`, API keys, tokens, private keys, cookies, session dumps.
  - Vendor dashboards exports and any customer PII (names, emails, phone numbers, addresses, documents).
- If a task requires adding/changing a secret:
  - Ask first.
  - Prefer documented mechanisms already used by the repo (Rails credentials, existing secret managers, CI secrets).
- Do not paste secrets into:
  - Git history, PR descriptions, commit messages, screenshots, logs, test fixtures.
- NEVER hardcode credentials in any configuration files

## Dependency changes require explicit approval

- Do not add or upgrade dependencies without asking first.
  - Examples: `Gemfile`, `Gemfile.lock`, `package.json`, `yarn.lock`.
- If a change appears necessary:
  - Explain why, list the exact files/versions that would change, and wait for confirmation.

## Project config changes require explicit approval

- Do not change project-wide configuration without asking first.
  - Examples: `config/**/*`, `Procfile*`, `Dockerfile*`, CI configs (`.github/**`), build tooling, linters/formatters, bundler/yarn settings, database config, nginx config in repo.
- Prefer feature-local changes that keep existing behavior and conventions.
- If a config change is required:
  - Propose the minimal change and impact (who/what it affects), then wait for confirmation.

## Never change OS or machine configuration

- Never modify the developer machine or OS settings.
  - Examples: `apt`, `brew`, system services, `/etc/*`, shell rc files, global git config, ssh config, kernel/network settings.
- If system setup is needed:
  - Provide instructions for the user to run manually (commands + rationale), but do not execute them.

## If a constraint blocks progress

- Stop and: 
  - Ask a clarifying question or;
  - Ask for confirmation to explicitly bypass the blocking constraint, or;
  - Offer a safe alternative that avoids secrets, new deps, config changes, or OS changes.
