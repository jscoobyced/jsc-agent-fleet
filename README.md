# JSC Agent Fleet

JSC Agent Fleet is an autonomous development workflow for running a coordinated set of AI agents across a software delivery lifecycle.

## Purpose

The project models a product-driven engineering process where specialized agents handle:

- product requirements
- business analysis and requirement refinement
- system design and implementation planning
- code implementation and validation
- staging and release readiness
- final human handoff for push and PR creation

## High-level workflow

PO → BA → LSE → SSE → DOE → Human final review / PR

## Repository structure

- `agents/` — role-based agent definitions
- `skills/` — reusable capabilities that agents use

## Notes

This project is designed to be reusable and structured around durable artifacts rather than conversational memory. Each feature run is isolated under `.ai/runs/<RUN_ID>/...` so work can be tracked, resumed, and reviewed independently.
