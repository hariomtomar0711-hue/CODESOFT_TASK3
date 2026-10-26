# CareerHub — Full-Stack Job Portal

A full-stack recruitment portal built with Next.js 14, React, TypeScript, Node.js route handlers, PostgreSQL, and Prisma.

## Fast start on Windows

### Requirements
- Node.js 20 or newer: https://nodejs.org/
- Docker Desktop: https://www.docker.com/products/docker-desktop/ (open it before starting)

### Run
1. Extract this project ZIP to a normal folder, for example `C:\CareerHub`.
2. Open that folder in File Explorer.
3. Click the address bar, type `powershell`, and press Enter.
4. Run:

   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   .\START-WINDOWS.ps1
   ```

5. Wait for setup. When the development server starts, open **http://localhost:3000**.
6. Keep that PowerShell window open while using the site. Press `Ctrl+C` to stop it.

The script starts the included PostgreSQL database using Docker, installs npm packages, creates the database tables, seeds demo data, and starts Next.js. On first run, package and database images need an internet connection.

## Demo accounts
Both seeded demo users use password `CareerHubDemo!2026`.

- Recruiter: `recruiter@careerhub.demo`
- Candidate: `candidate@careerhub.demo`

## Features

### Candidates
- Browse, search, and filter published jobs by keyword, location, and employment type.
- View job descriptions, requirements, salary ranges, and work arrangements.
- Register and sign in as a candidate.
- Maintain a profile with headline, bio, location, skills, and resume URL.
- Apply to a job with an optional cover letter; duplicate applications are prevented.
- Track application status and withdraw an active application.

### Recruiters
- Register a recruiter account with a company name.
- Publish job listings with salary range, work arrangement, description, requirements, and featured flag.
- View jobs and application counts.
- Review candidate details, skills, resume links, and cover letters.
- Update application status: Applied, Reviewing, Shortlisted, Interview, Offered, Rejected, Withdrawn.
- Close and reopen job listings.

### Platform
- Responsive home page, job search, job details, candidate dashboard, recruiter dashboard, and role-specific navigation.
- PostgreSQL schema managed with Prisma.
- Password hashing with bcrypt, signed HTTP-only session cookie, server-side role checks, and Zod request validation.
- Demo seed data for six jobs and two demo accounts.

## Stack
- Next.js 14 / React 18 / TypeScript
- Node.js route handlers
- PostgreSQL 16 (Docker Compose)
- Prisma ORM
- Responsive CSS, bcryptjs, Zod

## Useful commands

```powershell
npm run dev        # start local development server
npm run build      # production build
npm run db:generate
npm run db:push
npm run db:seed
```

## Main routes
- `/` — home page
- `/jobs` — job search
- `/jobs/[id]` — job details
- `/apply/[jobId]` — apply to a job
- `/register` and `/login` — authentication
- `/candidate` — candidate profile and application tracker
- `/recruiter` — recruiter dashboard
- `/recruiter/jobs/new` — publish a job
- `/recruiter/jobs/[id]` — manage a job and view applicants

## API routes
- `POST /api/auth/register`
- `POST /api/auth/login`
- `POST /api/auth/logout`
- `GET /api/jobs`
- `POST /api/jobs` (recruiter/admin)
- `GET /api/jobs/[id]`
- `PATCH /api/jobs/[id]` (owner/admin)
- `POST /api/jobs/[jobId]/apply` (candidate)
- `PATCH /api/applications/[id]` (candidate withdrawal or recruiter status update)
- `PATCH /api/candidate/profile`

## Notes
This is a functional educational starter project; it has not been security-audited or production-certified. Resume handling currently stores a resume URL rather than uploading file bytes to cloud storage. Before public deployment, add tests, email verification, password reset, rate limiting, audit logs, privacy/retention controls, HTTPS, backups, monitoring, and production secret management. Change demo passwords and remove demo accounts before public use.
