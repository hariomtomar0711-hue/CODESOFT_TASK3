$ErrorActionPreference = 'Stop'

Write-Host "`n=== CareerHub Job Portal setup ===" -ForegroundColor Cyan

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  Write-Host "Node.js 20+ is required. Install it from https://nodejs.org/ and reopen PowerShell." -ForegroundColor Yellow
  exit 1
}
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
  Write-Host "npm was not found. Reinstall Node.js 20+ from https://nodejs.org/." -ForegroundColor Yellow
  exit 1
}
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
  Write-Host "Docker Desktop is required for the included PostgreSQL database. Install/start it from https://www.docker.com/products/docker-desktop/" -ForegroundColor Yellow
  exit 1
}

if (-not (Test-Path '.env')) {
  Copy-Item '.env.example' '.env'
}

Write-Host "Starting PostgreSQL database..." -ForegroundColor Cyan
docker compose up -d postgres
if ($LASTEXITCODE -ne 0) { throw "Could not start PostgreSQL. Make sure Docker Desktop is running." }

Write-Host "Installing project packages..." -ForegroundColor Cyan
npm install
if ($LASTEXITCODE -ne 0) { throw "npm install failed." }

Write-Host "Generating Prisma client..." -ForegroundColor Cyan
npx prisma generate
if ($LASTEXITCODE -ne 0) { throw "Prisma client generation failed." }

Write-Host "Creating database tables..." -ForegroundColor Cyan
npx prisma db push
if ($LASTEXITCODE -ne 0) { throw "Database setup failed. Check Docker/PostgreSQL and .env." }

Write-Host "Adding demo data..." -ForegroundColor Cyan
npm run db:seed
if ($LASTEXITCODE -ne 0) { throw "Seeding demo data failed." }

Write-Host "`nSetup complete. Starting CareerHub at http://localhost:3000" -ForegroundColor Green
npm run dev
