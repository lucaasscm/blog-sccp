---
name: rwr
description: >-
  Research how production Rails apps solve architectural problems using Real World Rails repository.
  Only invoke when user EXPLICITLY requests: "use rwr skill", "check real world rails", "research rails patterns".
  Do NOT auto-invoke for general questions - user must explicitly mention this skill.
---

# Rails Pattern Research (Real World Rails)

## What This Is

Real World Rails is a collection of 200+ production Rails application source code.
Use this to research how real apps solve architectural problems.

**Notable apps:** Discourse, Mastodon, GitLab, Chatwoot, Spree, Solidus, Redmine, Canvas LMS

## Before You Start

1. **Check if repository exists:**
   ```bash
   ../real-world-rails/
   ~/real-world-rails/
   ```

2. **If not found:** Ask user where Real World Rails is located (or if they want to clone it)

3. **Repository structure:**
   ```
   real-world-rails/
   ├── apps/       # 200+ apps as git submodules
   └── engines/    # Rails engines
   ```

## What To Do

1. **Identify relevant apps for the research topic:**

   **E-commerce/Payments/Products:**
   - `apps/spree` - Full e-commerce platform
   - `apps/solidus` - Modern e-commerce (Spree fork)
   - `apps/sharetribe` - Marketplace platform

   **Events/Scheduling/Calendar:**
   - `apps/osem` - Event management
   - `apps/loomio` - Meeting/scheduling
   - `apps/discourse` - Event categories/tags

   **SaaS/Admin/Multi-user:**
   - `apps/gitlab` - Complex SaaS architecture
   - `apps/discourse` - Forum/community platform
   - `apps/chatwoot` - Customer support SaaS
   - `apps/redmine` - Project management

   **Notifications/Emails/Jobs:**
   - `apps/discourse` - Sophisticated notification system
   - `apps/gitlab` - Background job patterns
   - `apps/mastodon` - Real-time notifications

   **Reports/Analytics/Data:**
   - `apps/gitlab` - Complex reporting
   - `apps/canvas-lms` - Education analytics
   - `apps/redmine` - Project reports

   **API/Integrations:**
   - `apps/gitlab` - Extensive API
   - `apps/discourse` - Plugin system
   - `apps/chatwoot` - Third-party integrations

2. **Before searching, check if apps are initialized:**
   ```bash
   cd ../real-world-rails
   ls apps/spree  # If empty, submodule not initialized
   ```

3. **If app needed but not initialized, tell user:**
   ```
   Need to initialize apps/spree for this research.
   Run: cd ../real-world-rails && git submodule update --init --depth 2 apps/spree
   ```

4. **Search strategy:**
   - Use `grep` for patterns across initialized apps
   - Read actual code (models, schemas, migrations, concerns)
   - Compare 2-3 different implementations
   - Note differences and trade-offs

## Output Format

```markdown
## Pattern: {Topic}

**Apps needed (if not initialized):**
cd ../real-world-rails && git submodule update --init --depth 2 apps/spree apps/discourse

**Apps analyzed:** Spree, Discourse

**Common patterns:**
- {Pattern 1}: Used by Spree (brief description + file:line)
- {Pattern 2}: Used by Discourse (brief description + file:line)

**FestaLab recommendation:**
{Which pattern fits best and why - 1-2 sentences}
```

## When NOT to Use This Skill

❌ Don't use for:
- Questions already answered in `.opencode/memory/patterns.md`
- Standard Rails conventions (consult Rails guides)
- FestaLab-specific code (search the actual codebase)
- Quick "how do I" questions (answer directly)

✅ Use for:
- Unfamiliar architectural decisions
- Comparing multiple approaches in production
- Validating pattern choices before major refactoring
- Research on complex features (payments, notifications, reports)

## Token Efficiency

- Suggest 2-3 most relevant apps for the topic
- Check if apps initialized before searching
- Provide exact submodule init command if needed
- Grep first, read code second
- Synthesize findings concisely
- Don't paste large code blocks (reference file:line)

## Repository Setup (if needed)

If user doesn't have Real World Rails:

```bash
# Clone main repository (small, just structure)
git clone https://github.com/eliotsykes/real-world-rails.git ../real-world-rails
```

**Do NOT initialize all submodules** - there are 200+ apps.

**Initialize specific apps as needed:**
```bash
cd ../real-world-rails
git submodule update --init --depth 2 apps/discourse apps/spree
```

**Common apps to have ready:**
- `apps/discourse` - Notifications, jobs, complex domain
- `apps/spree` - E-commerce, products, payments
- `apps/gitlab` - SaaS architecture, API patterns

**Note:** Apps are git submodules. Minimum `--depth 2` required for submodules to work.
