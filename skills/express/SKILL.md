---
name: express
description: "Secure Node.js Express API implementation and review standards. Triggers on: build express API, write express service, create nodejs express app, implement JWT auth, add CORS, set CSP headers, add rate limiting, secure express server."
metadata:
  version: "1.0.0"
  author: "Cedric Rochefolle"
---

# Express API Security and Implementation Skill

You are the Express implementation specialist for this repository. Build production-grade Node.js/TypeScript APIs using secure defaults, clean architecture, and review-friendly structure. Apply the repository’s TypeScript, testing, and workflow standards for every implementation or review.

## When to use this skill

Use this skill when asked to:

- build express API
- write express service
- create nodejs express app
- implement JWT auth
- add CORS
- set CSP headers
- add rate limiting
- secure express server

## Core objectives

A correct Express implementation must:

- be secure by default
- keep authentication and authorization centralized
- validate all untrusted input before use
- avoid leaking sensitive internals in responses
- remain easy to test and easy to review
- satisfy lint, typecheck, and unit test gates before acceptance

## Inputs

Use existing run artifacts and codebase context as inputs:

- `.ai/runs/<RUN_ID>/requirements/prd-v2.md`
- `.ai/runs/<RUN_ID>/requirements/ba-analysis.md`
- `.ai/runs/<RUN_ID>/architecture/architecture.md`
- `.ai/runs/<RUN_ID>/plan/implementation-plan.md`
- `.ai/runs/<RUN_ID>/plan/task-graph.yaml`
- `.ai/runs/<RUN_ID>/tickets/TASK-*.md`
- current repository source and tests (`src/`, `test/`)

When present, use execution/review artifacts from prior attempts as additional context:

- `.ai/runs/<RUN_ID>/execution/TASK-*.md`
- `.ai/runs/<RUN_ID>/reviews/TASK-*.md`

If required requirement or plan artifacts are missing, stop and request them.

## Input examples and templates

Do not duplicate template files for this skill. Reuse existing examples by path:

- `skills/requirements-analysis/template/prd-v2.sample.md`
- `skills/task-planning/template/architecture.sample.md`
- `skills/task-planning/template/implementation-plan.sample.md`
- `skills/task-planning/template/task-graph.sample.yaml`
- `skills/task-planning/template/ticket.sample.md`

## Standard project structure

Use a predictable separation of concerns:

```text
src/
  app.ts
  server.ts
  config/
    env.ts
    cors.ts
    security.ts
    jwt.ts
  middleware/
    auth.ts
    errorHandler.ts
    notFound.ts
    requestLogger.ts
    rateLimit.ts
    validation.ts
  routes/
    index.ts
    health.ts
    auth.ts
    users.ts
  controllers/
    authController.ts
    userController.ts
  services/
    authService.ts
    userService.ts
  validation/
    auth.schema.ts
    user.schema.ts
  types/
    express.d.ts
```

Rules:

- route handlers stay thin
- controllers parse HTTP concerns only
- services own business logic and domain rules
- middleware owns auth, validation, and security enforcement
- config is centralized and loaded once during startup

## Application bootstrap requirements

The application should:

- create an Express app in a dedicated factory or `app.ts`
- separate server startup from application construction
- register middleware in a clear order
- centralize route registration and versioning
- register a final 404 handler and centralized error handler
- export the app instance for tests without starting the listener by default
- validate environment variables during startup and fail fast on missing required config

Recommended order:

```ts
const app = express();

app.set("trust proxy", 1);
app.use(cors(corsOptions));
app.use(helmet());
app.use(express.json({ limit: "1mb" }));
app.use(express.urlencoded({ extended: true }));
app.use(requestLogger);
app.use("/api", routes);
app.use(notFound);
app.use(errorHandler);
```

Do not put bootstrapping inside route modules or conditionally initialize the server at import time.

## Security headers and policy defaults

Apply strict default headers in every service unless a specific internal contract requires otherwise.

At minimum:

- `Content-Security-Policy`
- `X-Frame-Options: DENY`
- `X-Content-Type-Options: nosniff`
- `Referrer-Policy: no-referrer`
- `Permissions-Policy` with restrictive defaults
- `Strict-Transport-Security` in production behind HTTPS

Recommended CSP default for browser-facing API responses or HTML pages:

```http
Content-Security-Policy: default-src 'self'; base-uri 'none'; frame-ancestors 'none'; object-src 'none'; img-src 'self' data:; style-src 'self' 'unsafe-inline'; script-src 'self'; connect-src 'self'; form-action 'self'
```

Use Helmet when available and configure explicit policies when it is not sufficient. If the service is API-only, keep the policy strict but do not assume an overly broad CSP that breaks real browser clients.

## Cross-Origin Resource Sharing

CORS must be restrictive and explicit.

Requirements:

- allow only trusted origins from an environment allowlist
- reject wildcard origins in production unless the requirement is explicit and reviewed
- enumerate allowed methods and headers
- support preflight `OPTIONS` requests correctly
- disable credentials unless the use case truly requires them
- avoid `Access-Control-Allow-Origin: *` when credentials are enabled

Example pattern:

```ts
const allowedOrigins = (process.env.ALLOWED_ORIGINS ?? "http://localhost:3000")
  .split(",")
  .map((origin) => origin.trim());

const corsOptions = {
  origin: (origin, callback) => {
    if (!origin || allowedOrigins.includes(origin)) {
      callback(null, true);
      return;
    }

    callback(new Error("Origin not allowed by CORS"));
  },
  credentials: false,
  methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
  allowedHeaders: ["Content-Type", "Authorization"],
};
```

When the service must allow cookies, ensure same-site policy, explicit origins, and secure cookie configuration are documented and tested.

## Rate limiting

Apply rate limiting to public and sensitive endpoints, especially:

- authentication routes
- password reset or recovery flows
- user creation or bulk operations
- public health, status, and metadata endpoints if they are abused
- any endpoint with high cost or external side effects

Use a standard limiter with sensible defaults and per-route tuning.

Example policy:

```ts
const authLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 20,
  standardHeaders: true,
  legacyHeaders: false,
  message: { error: "Too many requests. Please try again later." },
  skipSuccessfulRequests: false,
});
```

Additional requirements:

- apply different limits for public vs authenticated traffic when appropriate
- set `trust proxy` carefully when behind a reverse proxy or load balancer
- return structured `429` JSON responses instead of generic HTML errors
- log rate-limit events for investigation without exposing secrets

## JWT authentication standards

JWT auth must be centralized and enforced in middleware, not repeated across routes.

Requirements:

- validate every bearer token on protected routes
- reject missing, malformed, expired, or invalid tokens with consistent `401` responses
- check required claims such as `sub`, `exp`, `iss`, `aud`, `role`, or `scope`
- ensure secret and key configuration is loaded from environment, not hardcoded
- keep token verification logic in one reusable helper or middleware module
- type `req.user` consistently instead of using untyped request data

Recommended pattern:

```ts
export function requireAuth(req: Request, res: Response, next: NextFunction) {
  const authHeader = req.headers.authorization;
  const token = authHeader?.startsWith("Bearer ") ? authHeader.slice(7) : null;

  if (!token) {
    return res.status(401).json({ error: "Authentication required" });
  }

  try {
    const payload = verifyJwt(token);
    req.user = payload;
    return next();
  } catch (error) {
    return res.status(401).json({ error: "Invalid or expired token" });
  }
}
```

For authorization checks:

- use a dedicated `requireRole(...)` or `requireScope(...)` guard
- keep route-level authorization logic declarative and minimal
- reject access with `403` when the user is authenticated but not authorized
- validate claim semantics, not only the presence of a token

Prefer asymmetric signing such as RS256 when the service participates in distributed or external trust boundaries. If using HS256 for internal-only services, keep the secret in a managed secret store and never commit it to source.

## Input validation and request safety

Never trust raw request data. Validate all of the following before service calls:

- request body
- query parameters
- route params
- headers when required
- cookies when used for auth or session state

Use a schema validator such as Zod, Joi, or `express-validator` and reject invalid inputs with a `400` response. Do not allow unvalidated data to reach services or database calls.

Required behaviors:

- reject missing required fields and malformed types
- trim unexpected whitespace or normalize values where appropriate
- reject oversized payloads and suspicious content types if necessary
- return stable, structured validation errors instead of stack traces
- centralize validation rules where they are easy to review and reuse

Example:

```ts
const createUserSchema = z.object({
  email: z.string().email(),
  password: z.string().min(12),
  name: z.string().min(2).max(100),
});
```

## Error handling standards

Use one centralized error handling path.

Rules:

- do not leak stack traces or internal implementation details in production
- return consistent JSON error payloads
- map validation failures to `400`
- map missing or invalid auth to `401`
- map permission failures to `403`
- map rate limiting to `429`
- map missing resources to `404`
- reserve `500` for unexpected server-side faults only

Example response format:

```json
{
  "error": "Validation failed",
  "details": ["password must be at least 12 characters"]
}
```

Do not swallow errors silently. Log actionable context, but do not expose internals to clients.

## Testing expectations

Every Express change must include behavior-focused tests for the public route and security behavior. Do not rely on implementation-only assertions or mock-only tests that do not exercise real HTTP behavior.

Minimum test coverage for new or changed routes:

- success path test
- validation failure test
- unauthorized access test
- forbidden access test for role or scope mismatch
- expired or malformed JWT rejection test
- rate-limit behavior test on sensitive endpoints
- CORS origin rejection/allowance test when applicable
- CSP or security-header assertion test where relevant

Use `supertest` against the exported app factory. Keep tests readable, decisive, and focused on behavior.

Example expectations:

- route returns `200` for valid input
- route returns `400` for invalid body schema
- protected route returns `401` without token
- protected route returns `403` when token lacks required scope
- login route returns `429` after repeated failures
- security headers are present on responses

## TypeScript and review standards

This skill follows the repository’s TypeScript and code-review standards.

Coding rules:

- avoid `any` unless there is a clear and documented reason
- prefer typed request/response payloads
- avoid mixing business logic into controllers
- prefer explicit constants over magic numbers in security configuration
- avoid unsafe `as` casts or unchecked assertions when the shape is not guaranteed
- use environment validation rather than silent fallback semantics for security settings

Reviewers should verify:

- lint passes
- `tsc --noEmit` passes
- relevant unit tests pass
- security-critical branches are covered by tests
- no sensitive variables or secrets are committed
- route behavior matches the intended API contract

## Workflow and deliverable expectations

For each Express feature or fix, produce implementation artifacts consistent with the repository workflow:

- route and middleware wiring
- secure auth and validation middleware
- rate limiting and CORS configuration
- error handling and response consistency
- tests covering both success and failure behavior
- environment variable requirements for production deployment

Before accepting a change, confirm the following checklist:

- [ ] app bootstraps cleanly and routes are registered
- [ ] CORS allows only approved origins
- [ ] CSP headers are present and defensible
- [ ] rate limiting is active on sensitive endpoints
- [ ] JWT validation is centralized and enforced
- [ ] invalid or expired tokens fail with structured `401` responses
- [ ] validation rejects malformed input before service logic runs
- [ ] tests cover auth, validation, and security denial paths
- [ ] lint and typecheck pass
- [ ] the implementation is consistent with project workflow and review requirements

## Related skills

This skill complements:

- `typescript`
- `nodejs`
- `testing`
- `code-review`

It also aligns with the repository workflow described in the autonomous development environment document: architecture, task planning, implementation, review, and quality gates must all be respected before code is treated as complete.
