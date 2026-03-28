---
name: frontend
description: Frontend UI development standards - Tailwind, Stimulus, components, accessibility
---

# Frontend Standards

**Read first:** `.opencode/memory/preferences.md` for naming and communication style.

Match existing FestaLab UI. Reuse components/utilities. No new design system.

## Before Coding

**Run locally:** `./bin/dev` (NOT `./bin/debug`)

## Controllers

**Strict routing:** Only standard resource actions (index, show, new, create, edit, update, destroy)
**DRY:** Use concerns or inherited controllers
**Views:** Use partials for sections

## Layout & Grid

- Use Tailwind utilities for spacing and layout
- Follow existing grid patterns (e.g., `grid-cols-2`, `gap-4`)
- Avoid custom CSS for layout unless necessary

## Typography & Colors
- Use Tailwind classes for fonts, sizes, and colors
- Follow existing color palette (e.g., `text-gray-700`, `bg-blue-500`)
- No new color variables without approval 

## CSS
- Avoid custom CSS files; prefer Tailwind utilities
- If necessary, use `@apply` in a single `app/assets/stylesheets/application.css` file
- No global CSS rules; scope styles to components or pages

## JavaScript
- Use Stimulus for interactivity
- Keep JS logic in controllers, not inline in views
- Avoid new JS libraries unless essential for functionality

## Accessibility
- Use semantic HTML elements (e.g., `<button>`, `<nav>`, `<main>`)
- Ensure all interactive elements are keyboard accessible
- Use ARIA attributes where necessary for screen readers
- Test with screen readers and keyboard navigation

## Performance

- No new JS dependencies
- No heavy images (use lazy-loading patterns)

## Delivery

- [ ] Matches design language (spacing, typography, buttons)
- [ ] Mobile first + desktop verified (+ `+desktop` variant if exists)
- [ ] No global CSS regressions
- [ ] `rake assets:precompile` succeeds (if touching assets)
