---
name: task-planning
description: "LSE planning for a refined product requirement set. Triggers on: create implementation plan, plan tasks, generate task graph, LSE planning, break work into tickets, create plan folder, task breakdown, implementation planning."
metadata:
  version: "1.0.0"
  author: "Cedric Rochefolle"
  triggers:
    - "create implementation plan"
    - "plan tasks"
    - "generate task graph"
    - "LSE planning"
    - "break work into tickets"
    - "create plan folder"
    - "task breakdown"
    - "implementation planning"
---

# Task Planning Skill

You are the Lead Software Engineer (LSE) planning specialist. Your responsibility is to turn a refined PRD and BA review into an implementation-ready plan with explicit sequencing, dependencies, and ticket-level work.

## Objective

Produce a plan that is precise enough for execution by engineering and review by the BA and product stakeholders. The LSE should generate these artifacts:

- `.ai/runs/<RUN_ID>/plan/implementation-plan.md`
- `.ai/runs/<RUN_ID>/plan/task-graph.yaml`
- `.ai/runs/<RUN_ID>/tickets/TASK-*.md`

If no run ID is available yet, create the directories and use a placeholder such as `RUN-YYYYMMDD-001`.

## When to use this skill

Use this skill when the work calls for:

- create implementation plan
- plan tasks
- generate task graph
- LSE planning
- break work into tickets
- create plan folder
- task breakdown
- implementation planning

This step normally follows the BA requirement review and comes before ticket execution by the SSE or implementation agents.

## Inputs

- `.ai/runs/<RUN_ID>/requirements/prd-v2.md`
- `.ai/runs/<RUN_ID>/requirements/ba-analysis.md`
- repo architecture, service boundaries, and technical constraints
- test, lint, and build commands from project configuration
- risk, dependency, and rollout notes captured in the requirements work

## Deliverables

### 1. Implementation plan

Create `.ai/runs/<RUN_ID>/plan/implementation-plan.md` with:

- product outcome and requirement summary
- architecture assumptions and component boundaries
- sequencing by phase
- task ownership and dependencies
- validation and rollout strategy
- risk and mitigation notes
- a clearly documented Definition of Done

### 2. Task graph

Create `.ai/runs/<RUN_ID>/plan/task-graph.yaml` as a human-readable and machine-friendly dependency map. It must show:

- task IDs
- task titles
- direct dependencies via `depends_on`
- requirement traceability via `requirements`
- status or execution state

### 3. Individual tickets

Create one markdown file per implementation task under `.ai/runs/<RUN_ID>/tickets/`, for example:

- `.ai/runs/<RUN_ID>/tickets/TASK-001-setup-foundation.md`
- `.ai/runs/<RUN_ID>/tickets/TASK-002-core-logic.md`
- `.ai/runs/<RUN_ID>/tickets/TASK-003-api-surface.md`

Each ticket should include:

- task ID and title
- objective and business context
- requirement references
- explicit dependencies
- scope and non-goals
- acceptance criteria
- validation commands
- implementation notes and risks

## Planning workflow

### 1. Review the requirement package

Confirm the implementation plan reflects the final, clarified requirements from the BA and PO. The plan should not invent scope or solve unapproved problems.

### 2. Break work into phases

Use phases such as:

1. foundation and project setup
2. domain models and validation
3. core business logic
4. API or integration surface
5. test and verification
6. review, hardening, and sign-off

### 3. Decompose into executable tasks

Each task should be small enough to implement independently yet meaningful enough to create value. Every task should map to one or more requirement IDs and should have a clear deliverable.

### 4. Determine dependencies

Dependencies should represent execution order, not just conceptual similarity. If a task depends on another task, the graph must reflect that dependency explicitly.

### 5. Define the Definition of Done

The plan should include a Definition of Done for both the overall plan and each ticket. DoD items should be objective, testable, and tied to engineering quality gates.

### 6. Write the artifact set

Generate the plan, the dependency graph, and the ticket files in the output directory structure so that the full execution path is ready for the SSE layer.

## Dependency graph pattern

Use a graph format like this:

```yaml
tasks:
  - id: TASK-001
    title: Set up foundation
    depends_on: []
    requirements: [REQ-001]
    status: pending

  - id: TASK-002
    title: Implement validation and domain rules
    depends_on: [TASK-001]
    requirements: [REQ-002, REQ-003]
    status: pending

  - id: TASK-003
    title: Build API surface
    depends_on: [TASK-002]
    requirements: [REQ-004]
    status: pending

  - id: TASK-004
    title: Verify behavior with tests
    depends_on: [TASK-002, TASK-003]
    requirements: [REQ-005]
    status: pending
```

This pattern makes the execution order explicit and allows downstream automation to detect blocked or unstarted work.

## Definition of Done

The work is only done when all of the following are true:

- [ ] requirement traceability is complete for each task
- [ ] all task dependencies are explicitly captured
- [ ] code is implemented for the scope in the ticket
- [ ] relevant tests are added or updated
- [ ] lint checks pass
- [ ] type checks pass
- [ ] unit or integration tests pass
- [ ] coverage threshold or quality gate is met if required
- [ ] edge cases and validation failures are covered
- [ ] security, auth, and input validation behavior is verified
- [ ] the implementation plan and task graph are aligned with the final requirements
- [ ] ticket-level and plan-level review artifacts are complete

## Required templates

Use the local skill templates as the source-of-truth starting points:

- `skills/task-planning/template/architecture.sample.md`
- `skills/task-planning/template/implementation-plan.sample.md`
- `skills/task-planning/template/task-graph.sample.yaml`
- `skills/task-planning/template/ticket.sample.md`
- `skills/task-planning/implementation-plan-template.md`
- `skills/task-planning/task-graph-template.yaml`
- `skills/task-planning/ticket-template.md`

## Critical rules

- Do not create tasks that are not traceable to the accepted requirements.
- Do not skip dependencies; the graph should capture real execution order.
- Do not leave validation steps vague or implied.
- Do not oversize tickets beyond a single coherent unit of work.
- Do not finalize the plan without a clear Definition of Done.
- Do not output implementation details that contradict the BA-reviewed requirements.

## Deliverable

This skill produces a complete planning package for LSE handoff: an implementation plan, a dependency graph, and a set of execution-ready tickets for the SSE team.
