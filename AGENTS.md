# ProductHub agent instructions

- Before repository exploration, read `check.md` in this project root for the current status, commands, constraints, and known issues.
- Inspect relevant source files before editing; validate checkpoint facts against current files when necessary.
- After each meaningful task and before handing back to the user, update `check.md`: completed work, actual verification results, unresolved issues, and next steps. Keep it concise and remove stale facts. Never include secrets.
- Preserve the existing application and product data. Keep project files and npm cache on D:. Avoid unnecessary dependencies or frameworks.
- Ask before destructive operations. The obsolete root `node_modules` must remain until the owner explicitly approves removal.
- Do not push/publish, alter Git history, or introduce Supabase credentials without authorization.
