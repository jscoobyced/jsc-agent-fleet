# Implementation Plan Template

## Output location

- `.ai/runs/<RUN_ID>/plan/implementation-plan.md`
- `.ai/runs/<RUN_ID>/plan/task-graph.yaml`
- `.ai/runs/<RUN_ID>/tickets/TASK-*.md`

## 1. Goal

Describe the business outcome, user value, and technical problem being solved. State the expected end state and the major constraints that shape the implementation.

## 2. Scope

- In scope
- Out of scope
- Dependencies and assumptions

## 3. Technical Approach

Summarize the intended design, component boundaries, and responsibilities across the implementation.

- API or transport concerns
- data flow and persistence
- security boundaries
- validation and error handling strategy
- observability and monitoring expectations

## 4. Architecture Notes

Document the relevant system components and the reason for the chosen structure.

- Routes or controllers
- service layer
- validation layer
- data or integration layer
- external dependencies
- testing strategy and rollout constraints

## 5. Phased Plan

### Phase 1: Foundation

- setup and configuration tasks
- scaffolding and shared utilities
- environment and dependency preparation

### Phase 2: Core logic

- business rules
- domain validation
- workflow orchestration

### Phase 3: API / integration surface

- routes and controller logic
- request validation and failure handling
- integration with downstream systems

### Phase 4: Quality and verification

- unit and integration tests
- linting and type checks
- review, hardening, and sign-off

## 6. Dependency Graph Pattern

Use a task graph where each task declares what it depends on and which requirements it satisfies.

```yaml
tasks:
  - id: TASK-001
    title: Setup foundation
    depends_on: []
    requirements: [REQ-001]
    status: pending

  - id: TASK-002
    title: Implement core behavior
    depends_on: [TASK-001]
    requirements: [REQ-002, REQ-003]
    status: pending

  - id: TASK-003
    title: Add validation and API integration
    depends_on: [TASK-002]
    requirements: [REQ-004]
    status: pending
```

## 7. Definition of Done

The implementation is complete only when all of the following are true:

- [ ] code for the task is implemented and reviewed
- [ ] each ticket is mapped to the relevant requirement IDs
- [ ] all dependencies are tracked and resolved before completion
- [ ] tests are added or updated for changed behavior
- [ ] lint checks pass
- [ ] type checks pass
- [ ] relevant unit or integration tests pass
- [ ] security, validation, and error behaviors are verified
- [ ] coverage or quality gates pass, if applicable
- [ ] final plan and task graph remain aligned with the approved requirement set

## 8. Risks and Mitigations

- Risk 1 -> Mitigation
- Risk 2 -> Mitigation
- Risk 3 -> Mitigation

## 9. Validation Plan

- command 1
- command 2
- test scenario 1
- regression scenario 1

## 10. Sign-off Notes

Document any open decisions, assumptions, or final review points before the work is considered ready to execute.
