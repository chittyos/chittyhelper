# AI Code Review — Tag-Only Flow

This repository uses a lightweight, tag-only approach to trigger your existing AI reviewers. No new reviewer code or keys are added; we only post a mention comment on PR open.

What’s enabled
- CodeRabbit App config via `.coderabbit.yml` (the app handles the review).
- Mention workflow: `.github/workflows/ai-review-mentions.yml` posts a comment tagging your AI reviewers.
- PR template includes the same mention lines for visibility.

Configure handles
- Set repository variables for your actual bot/team handles:
  - `MENTION_CODERABBIT` (default `@coderabbitai`)
  - `MENTION_CODEX` (default `@codex-review-bot`)
  - `MENTION_CLAUDE` (default `@claude-review-bot`)

Removed (to avoid duplicating your existing reviewers)
- Manual Codex/Claude workflows and scripts have been removed.
  - If needed in the future, they can be reintroduced as on-demand workflows.

