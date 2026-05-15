---
description: Perform a critical code review of the current PR and post it as a comment
---

# Code Review

Perform a thorough, critical code review of the current PR. Be rigorous — your job is to find problems, not to validate the work. Praise is cheap; useful criticism is what makes the codebase better.

## Setup

1. Identify the PR context:
   - Run `gh pr view --json number,title,body,baseRefName,headRefName,files,url` to get PR metadata.
   - Run `gh pr diff` to see the full diff.
   - If the PR description references an issue (e.g. `Closes #123`), run `gh issue view <number>` to extract the acceptance criteria.
   - If you're not on the PR branch, run `gh pr checkout <number>` first.

2. Understand the change:
   - Read the PR description and linked issue carefully — extract explicit acceptance criteria.
   - Identify which files changed and the scope of the change.
   - Read the surrounding code (not just the diff) to understand context — `git show`, `cat`, and `rg` are your friends. Many bugs are only visible when you understand what calls the changed code and what it calls into.

## Review Dimensions

Go through each category explicitly. Do not skip any.

### 1. Feature correctness
- Does the implementation actually do what the PR/issue describes?
- List each acceptance criterion and verify it against the code.
- Are there obvious gaps — missing edge cases, unhandled inputs, missing UI states, missing error paths?
- If the PR claims to fix a bug, is the root cause actually addressed or just the symptom?

### 2. Bugs and correctness
- Off-by-one errors, null/undefined handling, race conditions, incorrect async/await usage.
- Error handling: errors swallowed, logged but ignored, or propagated incorrectly?
- Resource leaks: unclosed connections, subscriptions, file handles, event listeners.
- Concurrency: shared mutable state, missing locks, incorrect transaction boundaries.
- Type safety holes: unsafe casts, `any` usage, `unwrap`/`expect` in Rust where it shouldn't be, non-exhaustive matches.
- Boundary conditions: empty collections, max values, unicode, timezones, DST.

### 3. Security
- Input validation, SQL injection, XSS, SSRF, path traversal.
- Authn/authz: are permission checks in the right place and enforced server-side?
- Secrets in code, logs, or error messages.
- Unsafe deserialization, unvalidated redirects.

### 4. Design and architecture
- Does this fit existing patterns in the codebase, or introduce inconsistency?
- Abstractions at the right level — over-engineered or under-engineered?
- Coupling: does this change reach into things it shouldn't?
- Is logic in the right layer (business logic in controllers, persistence concerns in domain code, etc.)?
- For event-sourced code: are aggregate invariants preserved? Are commands idempotent where they should be? Do events capture intent rather than state diffs?

### 5. Tests
- Are there tests? Do they actually test behavior, or just exercise the code?
- Are edge cases covered?
- Would the tests catch a regression of the bug being fixed?
- Are tests deterministic, or do they depend on time/order/network?
- For Rust: are `#[sqlx::test]` cases isolating their data correctly?

### 6. Performance
- N+1 queries, unnecessary loops, missing indexes.
- Allocations in hot paths.
- Sync work blocking async runtimes (`block_on` in async contexts, blocking I/O in Tokio tasks).
- Subject cardinality issues in NATS/JetStream subjects.

### 7. Observability
- Are spans/traces propagated correctly? `traceparent` carried across NATS message boundaries?
- Are logs at the right level — no debug spam in production paths, no silent failures?
- Are metrics emitted for things you'd want to alert on?

### 8. Maintainability
- Naming clarity, dead code, unclear comments, missing comments where intent is non-obvious.
- Magic numbers, duplicated logic.
- Public API changes — are they documented? Backwards-compatible?

## Output Format

Produce a single markdown report with this exact structure:

```
## Code Review

**Verdict:** Approve | Approve with comments | Request changes | Block

**Feature implementation:** One paragraph. Was the feature actually built as specified? Be specific about what's missing or wrong, with reference to the acceptance criteria.

### 🔴 Blocking issues
Bugs, security holes, broken functionality. If none, write "None."

### 🟡 Should fix before merge
Design problems, missing tests, significant maintainability concerns.

### 🔵 Suggestions
Nits, style, optional improvements.

### ✅ What works well
Brief — one or two genuine observations, not filler.
```

For each issue, include:
- File and line reference: `` `path/to/file.ext:42` ``
- What's wrong
- Why it matters
- Suggested fix (concrete, not vague)

## Posting the Review

Write the report to a temp file (so markdown formatting is preserved exactly), then post it:

```bash
gh pr comment --body-file /tmp/review-report.md
```

Confirm the comment was posted by printing the comment URL from the `gh` output.

## Rules

- **Be critical.** If you find nothing wrong, you didn't look hard enough. Don't manufacture issues — if something is genuinely fine, say so — but the default assumption is that every PR has problems worth surfacing.
- **Be specific.** "This could be cleaner" is useless. "Extract lines 45–80 into a `validateOrder` function — mixing validation and persistence here makes this untestable" is useful.
- **Read the actual code, not just the diff.** Bugs hide in the interaction between changed and unchanged code.
- **Verify, don't assume.** If the PR says "added caching," check that the cache is actually invalidated correctly.
- **Distinguish severity honestly.** Don't inflate nits to blocking issues, and don't downplay real bugs to suggestions.
- **No sycophancy.** Skip "Great work overall!" preambles. Get to the findings.
