# Architecture: Landing Page Counter

## Metadata

- Run: RUN-20260926-001
- Author: LSE
- Source Requirements: requirements/prd-v2.md
- Date: 2026-09-26

## 1. Architectural Decision Summary

- Use Express to serve static assets and index route.
- Keep counter state entirely in browser memory.
- Implement interaction logic in client-side TypeScript/JavaScript.
- Use lightweight test pyramid: unit tests for counter logic, E2E smoke for UI flow.

## 2. System Context

Actors:

- End user with browser.
- Express web server.

Data flow:

1. Browser requests `/`.
2. Express returns landing page assets.
3. Client script initializes counter (`0`).
4. User activates button.
5. Script increments in-memory value and rerenders count.
6. Refresh clears in-memory state and reinitializes to `0`.

## 3. Component Design

### Server Component

- Responsibility: Serve static landing page resources.
- Interface: `GET /`.
- No API endpoints required for counter updates.

### UI Component

- Responsibility: Render centered container with counter and button.
- Accessibility: semantic button text and keyboard support.
- Responsive behavior: center remains stable at 320px+ width.

### Counter Logic Component

- Responsibility: hold current count in memory and increment by one per activation.
- Invariant: `count` is integer and `count_next = count_prev + 1`.

## 4. Requirement Traceability

- REQ-001 -> Express route/static serving.
- REQ-002 -> Layout/CSS centering implementation.
- REQ-003 -> Counter initialization behavior.
- REQ-004 -> Increment logic and event handling.
- REQ-005 -> Refresh reset by in-memory state design.
- REQ-006 -> Keyboard activation and accessible label.

## 5. Testing Architecture

- Unit tests: initialization and increment invariants.
- E2E tests: page load, click increment, keyboard increment, refresh reset.
- Staging checks: health, load, browser compatibility smoke.

## 6. Trade-offs

- Chosen: in-memory state only.
- Rejected: localStorage persistence, because requirement explicitly expects reset on refresh.

## 7. Security and Reliability Notes

- No authentication or PII handling.
- Low security surface area due to static interaction.
- Reliability focus is deterministic UI behavior and repeatable tests.
