# Memory System

Meta-learning system for agents to remember user preferences and avoid repeated corrections.

## How It Works

### Daily Capture
Agents append learnings to `daily/{today}.md` during work:
- User preferences stated
- Patterns that emerged
- Decisions made
- Corrections given

### Weekly Consolidation (Manual)
User reviews `daily/*.md` files and extracts important items into:

- **`preferences.md`** - User style choices (naming, communication, workflow)
- **`patterns.md`** - Technical patterns used 3+ times
- **`decisions.md`** - Architectural decisions and rationale

### Agent Consumption
All agents read before starting:
1. `preferences.md` (always)
2. `patterns.md` (when coding)
3. `decisions.md` (when architecting)

## File Structure

```
.opencode/memory/
├── preferences.md          # User preferences (always read)
├── patterns.md             # Code patterns (read when coding)
├── decisions.md            # Architectural decisions (read when architecting)
├── daily/
│   ├── _template.md        # Template for daily capture
│   ├── 2026-02-27.md       # Today's learnings
│   └── 2026-02-28.md
└── archive/
    ├── 2026-week-08.md     # Consolidated weekly notes
    └── 2026-week-09.md
```

## Daily Capture Template

Use `daily/_template.md` to create new daily files:

```markdown
# {DATE}

## Code Preferences Identified
- [User stated preferences]

## Patterns Used
- [Recurring implementations]

## Decisions Made
- [Important choices]

## Pitfalls Avoided
- [Mistakes prevented]

## Corrections Given
- [Times user corrected behavior]

## Questions for Consolidation
- [Unclear items needing clarification]
```

## Weekly Consolidation Process

Every week (or when `daily/` gets too full):

1. **Review daily files:**
   ```bash
   cat .opencode/memory/daily/2026-02-*.md
   ```

2. **Extract important items:**
   - Preferences → Update `preferences.md`
   - Patterns (3+) → Update `patterns.md`
   - Decisions → Update `decisions.md`

3. **Archive consolidated dailies:**
   ```bash
   # Merge reviewed dailies
   cat daily/2026-02-*.md > archive/2026-week-09.md
   # Remove processed dailies
   rm daily/2026-02-*.md
   ```

4. **Update metadata:**
   - Update `<!-- Last updated: DATE -->` in consolidated files
   - Optionally track `<!-- Corrections avoided: N -->`

## Benefits

✅ **Reduces repeated corrections** - Agents learn user preferences  
✅ **Saves tokens** - No need to re-explain preferences each session  
✅ **Improves accuracy** - Agents follow project-specific patterns  
✅ **Knowledge accumulation** - Decisions and patterns documented over time  

## Examples

### Bad (without memory):
```
User: "Use full variable names, not abbreviations"
[Next day]
Agent: *generates code with `w` for wallet*
User: "I told you yesterday, use full names"
```

### Good (with memory):
```
preferences.md: "Variables: full words (wallet) NOT abbrev (w)"
Agent: *reads preferences.md*
Agent: *generates code with `wallet`*
User: ✅ No correction needed
```

## Metrics

Track in `preferences.md`:
```markdown
<!-- Last updated: 2026-02-27 -->
<!-- Corrections avoided this week: 12 -->
```

This helps measure system effectiveness over time.

## Guidelines

### What to Capture
✅ User-stated preferences  
✅ Repeated corrections (2+)  
✅ Patterns used 3+ times  
✅ Important architectural decisions  

### What NOT to Capture
❌ One-off implementation details  
❌ Obvious Rails conventions  
❌ Temporary workarounds  
❌ Vague or unclear preferences  

### Format Guidelines
- Keep entries **specific and actionable**
- Use ✅/❌ for clarity
- Include rationale when non-obvious
- Use examples for naming/style preferences

## Maintenance

- **Daily:** Agents append to `daily/{today}.md` automatically
- **Weekly:** User consolidates manually (10-15 min)
- **Monthly:** Review consolidated files for duplicates/obsolete items
- **Quarterly:** Archive old weekly files if needed

## Cron jobs to consolidade memories
```bash
crontab -e
```
add the following line to run the consolidation (remember to adjust the path and agent/model as needed):
```
0 8 * * 1 cd ~/code/personal_projects/blog-coringao && opencode run "consolidate memories from .opencode/memory/daily/ into weekly file inside .opencode/memory/archive/" --agent dev --model opencode/minimax-m2.5-free >> /tmp/opencode-consolidate.log 2>&1
0 8 1 * * cd ~/code/personal_projects/blog-coringao && opencode run "consolidate memories from .opencode/memory/archive/ into final files" --agent dev --model opencode/minimax-m2.5-free >> /tmp/opencode-archive.log 2>&1
```
