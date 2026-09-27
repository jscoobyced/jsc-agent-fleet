# Skills Registry

This directory contains the reusable domain skills used by the autonomous workflow.

## Overview

Each skill is a reusable capability, not a role. Agent roles invoke one or more skills depending on the task.

Template convention:

- Skills that generate artifacts should keep local examples under `skills/<skill-name>/template/`.
- Skills should reference only their local templates, not `docs/templates/` paths directly.

## Skills by domain

### Product and requirements

- `product-requirements`
  - Used by: PO
  - Purpose: draft the initial PRD from business input
  - Output: `.ai/runs/<RUN_ID>/requirements/prd-v1.md`
  - Trigger examples: "write PRD", "create product requirements", "draft feature requirements"

- `requirements-analysis`
  - Used by: BA
  - Purpose: review the PRD, identify gaps, and create the enriched PRD v2
  - Outputs:
    - `.ai/runs/<RUN_ID>/requirements/ba-analysis.md`
    - `.ai/runs/<RUN_ID>/requirements/prd-v2.md`
  - Trigger examples: "analyze requirements", "BA review", "clarify PRD", "prepare PRD v2"

### Planning and architecture

- `task-planning`
  - Used by: LSE
  - Purpose: generate architecture, implementation plan, task graph, and tickets
  - Outputs:
    - `.ai/runs/<RUN_ID>/architecture/architecture.md`
    - `.ai/runs/<RUN_ID>/plan/implementation-plan.md`
    - `.ai/runs/<RUN_ID>/plan/task-graph.yaml`
    - `.ai/runs/<RUN_ID>/tickets/TASK-*.md`
  - Trigger examples: "create implementation plan", "plan tasks", "generate task graph"

### Engineering

- `typescript`
  - Used by: SSE and review flows
  - Purpose: TypeScript patterns, type safety, project standards

- `nodejs`
  - Used by: SSE and Express implementation
  - Purpose: Node.js runtime conventions and project structure

- `express`
  - Used by: SSE
  - Purpose: Node.js/Express API security, JWT auth, CORS, CSP, rate limiting, validation
  - Trigger examples: "build express API", "implement JWT auth", "add CORS"

- `testing`
  - Used by: SSE
  - Purpose: test strategy, unit and integration coverage

- `code-review`
  - Used by: review stage and LSE/SSE quality checks
  - Purpose: enforce lint, typecheck, tests, coverage, and code quality standards
  - Trigger examples: "review TypeScript code", "check lint", "code review"

### Operations and release

- `docker`
  - Used by: DOE
  - Purpose: Docker build and environment validation

- `kubernetes`
  - Used by: DOE
  - Purpose: Kubernetes manifests and deployment readiness validation

- `release-notes`
  - Used by: BA and DOE
  - Purpose: release summary and final handoff preparation

## Skill contract pattern

Each skill file should contain:

- YAML frontmatter with `name` and `description`
- a clear purpose and scope
- required inputs
- expected outputs
- trigger words or phrases
- quality gates and failure conditions
