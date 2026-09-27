# BA Analysis Template

## Output location

- `.ai/runs/<RUN_ID>/requirements/ba-analysis.md`
- `.ai/runs/<RUN_ID>/requirements/prd-v2.md`

## 1. Overview

Provide a brief summary of the feature, business problem, and why the requirement work is needed. Include the target outcome and any business context that affects scope or priority.

## 2. Summary of Current PRD

Summarize the current PRD, highlighting which areas are already clear and which parts are still weak or incomplete.

## 3. Ambiguities and Gaps

- Gap or ambiguity 1: <what is unclear>
- Gap or ambiguity 2: <what is missing>
- Gap or ambiguity 3: <where the requirement is underspecified>

## 4. Missing Acceptance Criteria

Document missing or weak acceptance criteria by requirement ID.

- REQ-001: <missing outcome or condition>
- REQ-002: <missing edge case or expected behavior>
- REQ-003: <missing security, access, or error handling condition>

## 5. Roles, Permissions, and User Flows

Describe who can do what, which actors are involved, and what the key user flows look like.

- Primary user: <actor>
- Administrator or operator: <actor>
- External dependency: <system or team>
- Key flow: <step-by-step scenario>

## 6. Risks and Dependencies

Document any business, operational, security, or integration risk that affects the requirement or its implementation.

- Business dependency: <dependency or stakeholder requirement>
- External dependency: <system, vendor, or team dependency>
- Operational risk: <risk to delivery, support, or rollout>
- Security or compliance risk: <risk or control requirement>

## 7. Assumptions

- Assumption 1: <statement being assumed>
- Assumption 2: <condition that needs confirmation>

## 8. Clarification Questions

List the questions that must be answered before implementation can proceed.

- Question 1: <decision or missing fact>
- Question 2: <required clarification>
- Question 3: <decision that changes scope or acceptance criteria>

## 9. Recommended Changes to the PRD

Describe the changes needed to get the PRD to LSE-ready quality.

- Proposed change 1: <clarify a requirement or acceptance condition>
- Proposed change 2: <add missing role, permission, or edge case>
- Proposed change 3: <add non-functional or compliance expectations>

## 10. LSE Readiness Notes

Explain how the refined PRD is now ready for architecture and planning.

- Requirements are clear enough for design estimation.
- Missing decisions have been captured or resolved.
- Dependencies and constraints are explicit.
- Acceptance criteria are measurable and testable.
- The document is ready for backlog and implementation planning.

## 11. Traceability Notes

Map key requirements to business outcomes and downstream planning needs.

- REQ-001 → <business outcome>
- REQ-002 → <user outcome or operational requirement>
- REQ-003 → <risk, compliance, or dependency note>

## 12. Final Recommendation

State whether the PRD is ready for LSE handoff or whether specific clarifications are still required before engineering begins.
