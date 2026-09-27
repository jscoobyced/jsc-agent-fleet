# Autonomous Development Environment Index

This repository contains the reusable agent and skill framework for the autonomous development workflow.

## Workflow overview

PO → BA → LSE → SSE → DOE → human final push / PR creation

## Roles and agents

### PO

- Agent: [agents/po/AGENT.md](agents/po/AGENT.md)
- Skill: [skills/product-requirements/SKILL.md](skills/product-requirements/SKILL.md)
- Purpose: draft the initial product requirements document
- Output: `.ai/runs/<RUN_ID>/requirements/prd-v1.md`

### BA

- Agent: [agents/sa/AGENT.md](agents/sa/AGENT.md)
- Skill: [skills/requirements-analysis/SKILL.md](skills/requirements-analysis/SKILL.md)
- Purpose: review and refine the PRD into a business-ready requirement set
- Outputs:
  - `.ai/runs/<RUN_ID>/requirements/ba-analysis.md`
  - `.ai/runs/<RUN_ID>/requirements/prd-v2.md`

### LSE

- Agent: [agents/lse/AGENT.md](agents/lse/AGENT.md)
- Skill: [skills/task-planning/SKILL.md](skills/task-planning/SKILL.md)
- Purpose: create architecture and task plan from the refined PRD
- Outputs:
  - `.ai/runs/<RUN_ID>/architecture/architecture.md`
  - `.ai/runs/<RUN_ID>/plan/implementation-plan.md`
  - `.ai/runs/<RUN_ID>/plan/task-graph.yaml`
  - `.ai/runs/<RUN_ID>/tickets/TASK-*.md`

### SSE

- Agent: [agents/sse/AGENT.md](agents/sse/AGENT.md)
- Skills:
  - [skills/typescript/SKILL.md](skills/typescript/SKILL.md)
  - [skills/express/SKILL.md](skills/express/SKILL.md)
  - [skills/testing/SKILL.md](skills/testing/SKILL.md)
  - [skills/code-review/SKILL.md](skills/code-review/SKILL.md)
- Purpose: implement and validate the assigned engineering tasks
- Output: `.ai/runs/<RUN_ID>/execution/TASK-XXX.md`

### DOE

- Agent: [agents/doe/AGENT.md](agents/doe/AGENT.md)
- Skills:
  - [skills/docker/SKILL.md](skills/docker/SKILL.md)
  - [skills/kubernetes/SKILL.md](skills/kubernetes/SKILL.md)
  - [skills/release-notes/SKILL.md](skills/release-notes/SKILL.md)
- Purpose: staging validation, release readiness, and final operational checks
- Outputs:
  - `.ai/runs/<RUN_ID>/staging/staging-report.md`
  - `.ai/runs/<RUN_ID>/releases/release-notes.md`

## Repository structure

- [agents/README.md](agents/README.md)
- [skills/README.md](skills/README.md)

## Notes

- The BA role is represented by the Business Analyst agent under [agents/sa/AGENT.md](agents/sa/AGENT.md).
- Skills are reusable capabilities; agents define the role and workflow responsibilities.
- All artifacts are intended to live under `.ai/runs/<RUN_ID>/...` for a given feature or change.
