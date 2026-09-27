# Product Requirements Document Template

## 1. Title

<Feature or change name>

## 2. Overview

Provide a concise summary of the business opportunity, customer problem, and the expected outcome. Explain why this change matters now and what value it creates for the business or user.

## 3. Problem Statement

Describe the current pain points, user frustrations, operational issues, or missed opportunities. Explain who is affected and what the business is trying to achieve.

## 4. Goals

- Goal 1: <measurable business outcome>
- Goal 2: <customer or user outcome>
- Goal 3: <operational or quality outcome>

## 5. Non-goals

- Out of scope item 1
- Out of scope item 2
- Out of scope item 3

## 6. Users and Personas

Describe the relevant users, administrators, operators, or system actors involved.

- Primary user: <user type>
- Secondary user: <user type>
- Admin or operator: <role>
- External system or integration: <system>

## 7. User Needs and Business Context

Explain the context in which this work occurs, including business constraints, operating conditions, stakeholder expectations, and any required compliance, policy, or regulatory requirements.

## 8. Functional Requirements

Document the required product behavior in clear, testable statements.

### REQ-001: <Requirement name>

The system must <business behavior or outcome> under <condition or scenario>.

### REQ-002: <Requirement name>

The system must <business behavior or outcome> when <trigger or condition> occurs.

### REQ-003: <Requirement name>

The system must <business behavior or outcome> for <user or actor> in <specific context>.

## 9. User Stories

### US-001: <Story title>

As a <user>, I want <goal> so that <benefit>.

**Acceptance Criteria**

- [ ] <observable outcome 1>
- [ ] <observable outcome 2>
- [ ] <error or edge case handling>

### US-002: <Story title>

As a <user>, I want <goal> so that <benefit>.

**Acceptance Criteria**

- [ ] <observable outcome 1>
- [ ] <observable outcome 2>
- [ ] <error or edge case handling>

## 10. Acceptance Criteria

List the success conditions for the feature from a product perspective.

- [ ] The system must <expected outcome> when <condition>.
- [ ] The system must <expected outcome> for <user or role>.
- [ ] The system must handle <invalid or edge-case scenario> with <expected behavior>.
- [ ] The system must provide <user-visible message, state, or signal> when <event occurs>.

## 11. Non-functional Requirements

Describe quality, performance, and operational expectations.

- Security: <authentication, authorization, data protection, audit, or privacy constraints>
- Performance: <response time, throughput, or latency expectations>
- Reliability: <availability, recovery, or resilience expectations>
- Accessibility: <WCAG or usability expectations>
- Observability: <logging, metrics, or monitoring expectations>
- Privacy and Compliance: <data handling or regulatory requirements>
- Compatibility: <supported browsers, devices, integrations, or environments>

## 12. Dependencies and Constraints

Document dependencies, assumptions, and business constraints that affect delivery.

- Existing systems or services involved
- Required user roles or permissions
- External dependencies or vendors
- Compliance, legal, or policy constraints
- Deployment, migration, or rollout limitations
- Operational or support responsibilities

## 13. Risks and Assumptions

### Risks

- Risk 1: <description and business impact>
- Risk 2: <description and business impact>

### Assumptions

- Assumption 1: <condition or expectation>
- Assumption 2: <condition or expectation>

## 14. Open Questions

Document any unresolved issues that must be clarified before implementation or sign-off.

- Question 1: <what is unknown or undecided>
- Question 2: <what is unknown or undecided>
- Question 3: <what is unknown or undecided>

## 15. Success Metrics

Define how business success will be measured.

- Metric 1: <target or benchmark>
- Metric 2: <target or benchmark>
- Metric 3: <target or benchmark>
- Metric 4: <qualitative or operational indicator>

## 16. Rollout / Release Considerations

Describe the product release strategy and operational readiness.

- Deployment approach and sequencing
- User communication or change management needs
- Backward compatibility considerations
- Data migration or transformation requirements
- Support plan and rollback strategy
- Release gates or validation steps before broad rollout

## 17. Final PRD Notes

Capture any additional context that teams need before planning or implementation.

- Key stakeholder alignment notes
- Decision history or trade-offs
- Any follow-up items required from product, legal, or operations
- Proposed next review step before engineering begins

## 18. Required output location

This PRD should be written to:

- .ai/runs/<RUN_ID>/requirements/prd-v1.md

Ensure the document is saved as the first version of the product requirements and is ready for BA review and downstream planning work.
