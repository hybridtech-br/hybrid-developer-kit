# Contributing to HYBRID Developer Platform

Thank you for helping improve the HYBRID Developer Platform (HDP).

## Principles

- Be truthful about implementation status and limitations.
- Keep changes small, reviewable, and documented.
- Preserve cross-platform compatibility for Linux, macOS, and Windows.
- Never commit secrets, credentials, tokens, or private customer data.
- Prefer deterministic scripts and idempotent operations.

## Development workflow

1. Create a branch from `main` using one of these prefixes:
   - `feature/`
   - `fix/`
   - `docs/`
   - `chore/`
2. Make focused changes.
3. Run the local validation commands.
4. Update documentation and `CHANGELOG.md` when applicable.
5. Open a pull request using the repository template.
6. Merge only after required checks pass.

## Local validation

```bash
bash -n install.sh
find scripts -type f -name '*.sh' -print0 | xargs -0 -n1 bash -n
shellcheck -x install.sh scripts/shared/*.sh scripts/linux/*.sh
HYBRID_WORKSPACE="${TMPDIR:-/tmp}/hybrid-workspace" NO_COLOR=1 ./install.sh
```

## Commit messages

Use Conventional Commits where possible:

- `feat:` new functionality
- `fix:` bug fix
- `docs:` documentation
- `test:` tests
- `ci:` CI/CD changes
- `chore:` maintenance
- `refactor:` internal restructuring

## Pull requests

A pull request should include:

- a clear problem statement;
- a concise summary of the solution;
- validation evidence;
- known limitations and risks;
- platform impact for Linux, macOS, and Windows.

## Security

Do not report vulnerabilities in public issues. Follow `SECURITY.md`.
