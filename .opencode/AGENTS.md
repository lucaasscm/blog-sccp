# Architecture

- Ruby 3.4.4
- Ruby on Rails 8.2.0.alpha
- MySQL (Rails native)
- Solid trifecta: Solid Cache, Solid Queue, Solid Cable
- Minitest < 6

# Communication & Token Efficiency

**ALL agents and skills MUST follow:** `.opencode/memory/preferences.md` → Communication Style section

**Summary: BE CONCISE. BE DIRECT. BE PRODUCTIVE.**
- No Rails 101 explanations, only if asked
- No filler content
- Execute first, explain only if needed

# Memory System (Meta-Learning)

**Before starting ANY task:**

1. **ALWAYS read:** `.opencode/memory/preferences.md`
2. **Read if coding:** `.opencode/memory/patterns.md`
3. **Read if architecting:** `.opencode/memory/decisions.md`

**During conversations (MANDATORY):**

Whenever relevant learnings occur (corrections, decisions, patterns), immediately append to `.opencode/memory/daily/{today}.md`. Don't wait until end of session. Be extremely concise.

- User stated a preference? → "Code Preferences Identified"
- User corrected your behavior? → "Corrections Given"
- Pattern used 3+ times? → "Patterns Used"
- Architectural decision made? → "Decisions Made"
- Mistake avoided? → "Pitfalls Avoided"

**How to append:**
1. Read existing `daily/{today}.md` (or use `_template.md` if doesn't exist)
2. Append your learnings under appropriate sections
3. Be extremely concise: 1 line per item, actionable format

**Weekly consolidation (user-driven):**

User will review `daily/*.md` files and consolidate important learnings into:
`.opencode/memory/archive/{year}{week_number}.md`

**Final consolidation (user-driven):**

User will review `archive/*.md` files and consolidate important learnings into:
- `preferences.md` - User preferences and style choices
- `patterns.md` - Recurring technical patterns
- `decisions.md` - Architectural decisions and rationale

# Mandatory instructions (run for every task)

- `.opencode/instructions/preflight.md`
- `.opencode/instructions/project-constraints.md`

# General standards

- Avoid using comments within the code, you don't need to explain the code, it must be legible itself.

## We prefer:
- Small single responsability methods instead of giant methods with multiple responsabilities
- Logic in controller/helpers instead of use it directly into the views
- The views must be concise and use partials to organize

# Task-specific skills

The Opencode skill system loads skills from `.opencode/skills/{name}/SKILL.md`. Use the `skill` tool to activate:

- Backend changes: `skill name: backend`
- Frontend/UI changes: `skill name: frontend`
- Tests/fixtures changes: `skill name: tests`


# Before finishing
- Run `bin/rubocop -A` if you made code changes.
