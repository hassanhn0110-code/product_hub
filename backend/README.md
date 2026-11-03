# ProductHub backend plan

ProductHub will use hosted Supabase for PostgreSQL, authentication, and product-image storage. There is no separate backend server, local database, or active Supabase connection today.

## Planned product database

A future `products` table can contain:

| Column | Purpose |
| --- | --- |
| id | Unique product identifier; choose the ID strategy during migration |
| name | Product display name |
| price | Numeric amount in PKR; non-negative |
| category | Product category |
| icon | Current emoji fallback |
| image_path | Optional path to a product image in Storage |
| created_at | Creation timestamp |

The three existing products remain in `frontend/src/App.jsx`. A future migration must preserve their names, prices, categories, and icons.

## Responsibilities

- Database schema changes, migrations, and access policies will belong in `backend/supabase/` once Supabase tooling is introduced.
- Supabase Auth will handle sign-in and sessions. Frontend service functions will call Auth and provide session information to the UI.
- Supabase PostgreSQL will store products and future customer data. Enable row-level security and define explicit access policies before connecting the public frontend.
- Supabase Storage will hold product images with explicit bucket access policies.
- Privileged actions, such as payment verification and administrative updates, will belong in server-side Supabase Edge Functions under `backend/supabase/functions/` when needed. Secrets belong in the hosted function environment.

Never expose a service-role or secret key in frontend code or a `VITE_` variable. Public project configuration alone does not protect data: database and storage policies enforce access.

No backend dependencies or credentials are required for the current demo.
