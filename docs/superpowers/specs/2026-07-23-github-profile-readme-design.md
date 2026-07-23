# GitHub Profile README Design Spec

**Date:** 2026-07-23  
**Repository:** [husnain-ce/husnain-ce](https://github.com/husnain-ce/husnain-ce)  
**Owner:** Muhammad Husnain (@husnain-ce)

## Purpose

Redesign the GitHub profile README into a clean, enterprise-grade Tech Showcase that communicates expertise within five seconds while highlighting security/AI projects and maintaining full analytics widgets.

## Design Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Archetype | Tech Showcase | Skills grid + featured projects; lighter career narrative |
| Featured projects | Auto-curated (6 repos) | Strongest defensible security/AI work |
| Analytics | Full widgets | User preference; stats, trophies, streak, graph, WakaTime |
| Tone | Enterprise professional | Removed "grey hat" language; impact-focused copy |
| Animations | 1 typing SVG + 1 banner GIF | Reduced visual noise from duplicate animations |

## Layout Structure

1. **Hero** — Banner GIF, name, title, tagline, single typing SVG, quick badges
2. **About** — 4 bullet points (current role, focus, leadership, open to)
3. **Featured Projects** — 2×3 table with impact descriptions and tech badges
4. **Technical Expertise** — 6 badge-only groups (no redundant HTML tables)
5. **GitHub Analytics** — Unified algolia/github-dark theme across all widgets
6. **Connect** — Shields.io badges for LinkedIn, GitHub, Stack Overflow, website

## Featured Projects

| Project | Impact |
|---|---|
| HackBot | AI cybersecurity assistant for Q&A, code analysis, scan review |
| Technology-Detection | Web tech fingerprinting with WhatWeb/Wappalyzer |
| shodan-cloud-docker | Cloud asset discovery via Shodan dorks |
| web-recon-automation | Subdomain, port, directory enumeration pipeline |
| awesome-api-security | Curated API security tools and resources |
| AI-Platforms-Directory | Global AI/LLM platforms directory |

Excluded from showcase: repos with offensive/malware-adjacent naming (ADS_manipulation, chrome_grabber) to maintain enterprise positioning.

## Visual System

- **Badge style:** `for-the-badge` with `#05122A` background
- **Accent colors:** `#58A6FF` (links/stats), `#3FB950` (security green)
- **Dividers:** Markdown `---` between major sections
- **Social icons:** Shields.io (replaced doodle-style icons)

## Content Updates

- **Role:** Updated to AI & Cyber Security Lead at Cyber Evangelists | Technology Head, AQSEC
- **Removed:** Duplicate typing SVGs, footer banner GIF, 15 redundant skill tables, "grey hat" phrasing, duplicate "Open to Opportunities" footer
- **Preserved:** Existing banner asset (`prorfile-bg-1.gif`), WakaTime user ID, all analytics widget endpoints

## Success Criteria

- README length reduced from ~800 to ~250–350 lines
- All 6 featured project links resolve
- Analytics widgets render with consistent theming
- Profile communicates specialty within 5 seconds of viewing

## Risks and Mitigations

| Risk | Mitigation |
|---|---|
| Third-party widget downtime | Static tagline text above typing SVG as fallback |
| Sensitive repo exposure | Auto-curation excludes offensive-adjacent projects |
| Broken external links | Verified LinkedIn, Stack Overflow, website URLs from prior README |
