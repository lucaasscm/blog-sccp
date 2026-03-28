# .opencode Structure

Configuration and context for AI agents working on FestaLab.

## 📁 Directory Structure

```
.opencode/
├── AGENTS.md                    # Entry point - loaded for all tasks
├── opencode.jsonc               # Tool configuration (permissions, disabled agents)
│
├── agent/                       # Specialized agents
│   ├── dev.md                   # Rails development (backend/frontend/tests)
│   ├── reviewer.md              # Code review and quality audit
│   ├── task-planner.md          # Break tasks into subtasks
│   └── doc-architect.md         # Documentation generation
│
├── skills/                      # Domain-specific implementation guides
│   ├── backend/SKILL.md         # Backend patterns (models, services, jobs)
│   ├── frontend/SKILL.md        # Frontend patterns (CSS, Stimulus, design system)
│   ├── tests/SKILL.md          # Testing standards (Minitest, fixtures)
│   └── rwr/SKILL.md            # Real World Rails research
│
├── instructions/                # Mandatory workflow rules
│   ├── preflight.md             # Check branch before coding
│   └── project-constraints.md   # Safety constraints (secrets, deps, config)
│
└── memory/                      # Meta-learning system
    ├── README.md                # How the memory system works
    ├── preferences.md           # User preferences (ALWAYS read)
    ├── patterns.md              # Technical patterns (read when coding)
    ├── decisions.md             # Architectural decisions (read when architecting)
    ├── daily/                   # Daily learnings capture
    │   ├── _template.md
    │   └── YYYY-MM-DD.md
    └── archive/                 # Weekly consolidations
        └── YYYY-week-WW.md
```

## 🎯 Key Files

### Always Loaded
- **`AGENTS.md`** - Project architecture, memory system instructions
- **`memory/preferences.md`** - User style, naming, communication rules
- **`instructions/preflight.md`** - Branch check before coding
- **`instructions/project-constraints.md`** - Security/safety rules

### Loaded by Context
- **`agent/*.md`** - When specific agent is invoked
- **`skills/{name}/SKILL.md`** - Loaded when skill is invoked via `skill` tool
- **`memory/patterns.md`** - When implementing features
- **`memory/decisions.md`** - When making architectural choices

## 🔄 Memory System

Agents learn from user corrections to reduce repeated mistakes:

1. **During work:** Agents append learnings to `memory/daily/{today}.md`
2. **Weekly:** User consolidates important items into `preferences.md`, `patterns.md`, `decisions.md`
3. **Future tasks:** Agents read consolidated memories and avoid repeating mistakes

**See:** `memory/README.md` for full details

## 🚀 Quick Reference

### For Agents
1. Read `AGENTS.md` first
2. Read `memory/preferences.md` (always)
3. Read `memory/patterns.md` if coding
4. Read `memory/decisions.md` if architecting
5. Append learnings to `memory/daily/{today}.md`

### For Users
- **Update preferences:** Edit `memory/preferences.md` directly
- **Weekly consolidation:** Review `memory/daily/*.md`, extract to core files
- **Add constraints:** Edit `instructions/project-constraints.md`

## 📊 Token Efficiency

**Total size:** ~1200 lines of markdown
- Core always loaded: ~250 lines (AGENTS.md + preferences.md + instructions)
- Skills loaded by dev agent: ~275 lines
- Memory loaded on-demand: ~170 lines

**Design principle:** Minimal, actionable, no redundancy.

## 🔧 Maintenance

- **Daily:** Agents auto-append to `daily/` (no action needed)
- **Weekly:** Consolidate `daily/*.md` → core files (10-15 min)
- **Monthly:** Review for duplicates/obsolete entries
- **Quarterly:** Archive old weekly files if needed
