# ProductHub

ProductHub is a demonstration electronics storefront built while learning full-stack web development. It includes a homepage, featured Samsung Galaxy, HP Laptop, and Wireless Headphones products, service information, and responsive styling. Product data is currently local; checkout and account features are future work.

## Technology

React 19, JavaScript/JSX, Vite 8, CSS3, Node.js, npm, and Oxlint. Supabase is planned for PostgreSQL, authentication, and storage. Git/GitHub are planned for version control; nothing has been published.

## Structure

```text
producthub/
|-- frontend/
|   |-- public/
|   |-- src/
|   |   |-- assets/
|   |   |-- components/       (reserved, currently empty)
|   |   |-- pages/            (reserved, currently empty)
|   |   |-- services/         (reserved, currently empty)
|   |   |-- styles/
|   |   |   |-- App.css
|   |   |   `-- index.css
|   |   |-- App.jsx
|   |   `-- main.jsx
|   |-- .oxlintrc.json
|   |-- index.html
|   |-- package.json
|   |-- package-lock.json
|   `-- vite.config.js
|-- backend/
|   `-- README.md
|-- docs/
|   |-- architecture.md
|   |-- original-files.json
|   `-- original-vite-readme.md
|-- .env.example
|-- .gitignore
|-- .npmrc
|-- package.json
`-- README.md
```

## Install and run on Windows

Use PowerShell and an up-to-date Node.js version compatible with the existing frontend package. This refactor was performed with Node.js 26.13.0 and npm 11.20.0.

```powershell
Set-Location 'D:\WebDevelopment\Projects\producthub'
npm.cmd --prefix frontend ci --cache D:\WebDevelopment\npm-cache
npm.cmd run dev
```

Open the local address Vite prints, usually http://localhost:5173. Press Ctrl+C to stop the server. Install is needed for a fresh checkout or changed dependencies, not every launch. The root has no packages to install.

The root `.npmrc` keeps the npm cache on D: for commands run here. The explicit cache option above also protects installs launched with `--prefix`. If the project is moved to another computer, update this machine-specific path.

## Build, lint, and preview

Run these from the project root:

```powershell
npm.cmd run build
npm.cmd run lint
npm.cmd run preview
```

The build produces `frontend/dist/`. Preview serves that production build locally; it is not a production hosting service. Each root command delegates to the frontend package using `--prefix`.

## Open in VS Code

```powershell
Set-Location 'D:\WebDevelopment\Projects\producthub'
code .
```

If `code` is unavailable, open VS Code, choose File > Open Folder, and select the same project folder.

## Planned Supabase integration

Supabase will provide the product database, user accounts, and image storage. Future client setup and queries belong in `frontend/src/services/`. Backend migrations, policies, and privileged functions belong under `backend/` when implemented. See [architecture](docs/architecture.md) and the [backend plan](backend/README.md).

There are no Supabase credentials or connections today. When integration is added, copy `.env.example` to `frontend/.env.local` and provide only public configuration. Never put passwords or service-role/secret keys in frontend code. Database and storage access policies must be configured before enabling access.

## Future features

- Product data from Supabase, with loading and error states
- Dedicated category filters (real-time name/category search is implemented)
- Sign-in and account pages
- Product images from Storage
- Cart and a carefully designed checkout flow

## GitHub repository

Repository: [hassanhn0110-code/product_hub](https://github.com/hassanhn0110-code/product_hub). The original project folder is a Git repository on `main`, with this repository configured as `origin`. The root ignore file excludes dependencies, generated builds, environment secrets, logs, and local editor files while keeping `.env.example`. Review files for secrets before future commits.

## Dependency cleanup

The original root `node_modules` is temporarily retained for safety. New installs belong only in `frontend/node_modules`; dependencies have not been manually copied or moved. Remove the obsolete root directory only after successful verification and your explicit approval. Do not reinstall dependencies at the root.

The root dev/build commands use Vite's native config loader to avoid a Windows process-permission error encountered with the default bundled config loader on this computer. The original frontend scripts, dependencies, and Vite config remain intact. Use the verified Node.js version above for these commands.
