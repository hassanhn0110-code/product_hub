# ProductHub architecture

## Current application

ProductHub is a React application served by Vite. `frontend/src/main.jsx` mounts `App.jsx`, which displays the existing homepage and three products. Prices, categories, and icons remain in App.jsx. React useState holds the search input; trim() and toLowerCase() normalize it, and filter()/includes() match product names or categories. The clear button resets the query. A live status displays result counts or the no-results message. Styles are in `frontend/src/styles/`; static public files keep their existing URLs.

Root npm scripts forward commands to `frontend` with npm's `--prefix` option. Dependencies are declared and locked only by the frontend package. The root package has no dependencies.

## Folder responsibilities

- `frontend/src/components/`: reusable interface pieces when useful extractions arise.
- `frontend/src/pages/`: page-level components when additional pages are implemented.
- `frontend/src/services/`: future Supabase client setup and data-access functions.
- `frontend/src/styles/`: the original app and global CSS.
- `frontend/src/assets/`: bundled images and SVG files.
- `frontend/public/`: files served directly by Vite.
- `backend/`: backend design now; future Supabase migrations, policies, and Edge Functions.
- `docs/`: architecture and migration records.

Components, pages, and services are intentionally empty today. Empty folders are not tracked by Git; create them as needed after a fresh clone. The small existing homepage stays together to preserve behavior.

## Planned Supabase flow

1. A React component asks a function in `src/services/` for product data.
2. That function uses a future Supabase JavaScript client and public project configuration.
3. Supabase checks database access policies and returns allowed rows over HTTPS.
4. React renders the returned products, including loading and error states when implemented.

For sign-in, service functions will call Supabase Auth. The client session identifies the signed-in user; database row-level security still decides which rows they can read or change. Product images will come from Supabase Storage according to bucket policies.

Operations needing private credentials must run in Supabase Edge Functions. A browser must never receive secret/service-role keys. There is no Supabase SDK installed, no database, and no network-backed product fetching in the current demo.

## Environment configuration

The root `.env.example` is a future configuration template. When Supabase is implemented, copy it to `frontend/.env.local`, because Vite reads environment files from the frontend application directory. `VITE_` values are visible in browser code; only public configuration belongs there. Restart the development server after changing environment files.

## Preservation

`original-files.json` records pre-refactor SHA-256 hashes for the original source and public assets. During the original refactor, only the two stylesheet import paths changed in React source. The subsequent search task intentionally added state/filtering/UI to App.jsx and styles to App.css. These hashes describe the historical pre-refactor files, not the current application. The original Vite template README is preserved as `original-vite-readme.md`. The frontend package files and Vite/Oxlint configuration were moved without dependency changes.

The old root `node_modules` remains pending the owner's approval to remove it after verification. Never copy or manually move dependency directories. npm installs the frontend dependency tree from its lockfile, using the D: download cache.
