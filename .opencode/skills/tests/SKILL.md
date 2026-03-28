---
name: tests
description: Testing standards - Minitest, fixtures, system tests, determinism
---

# Tests Standards

**Read first:** 
- `.opencode/memory/preferences.md` for naming and communication style
- `.opencode/db/minimal_schema.md` for database structure when needs to understand relations (use grep to search specific tables/associations, avoid reading entire file)

## Framework

Minitest + fixtures

## Rules

**Fixtures:**
- Avoid creating new ones

**System tests:**
- Explain why needed
- Ask permission first

**Determinism:**
- Order by `:id` before `.first`/`.last`
- Example: `Invitation.order(:id).last`

**External calls:**
- Ask before real HTTP requests
- Default: stub at client boundary

## Running

Only run when:
- Explicitly requested
- Task requires verification

If broken, suggest alternative verification.
