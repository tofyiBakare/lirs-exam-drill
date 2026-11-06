-- Run once in Supabase: SQL Editor → New query → paste → Run.

-- One row per user: running progress (scores per question, misses, stars, exam summaries).
create table if not exists public.progress (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- One row per mock exam attempt.
create table if not exists public.attempts (
  id                 bigint generated always as identity primary key,
  user_id            uuid not null default auth.uid() references auth.users(id) on delete cascade,
  started_at         timestamptz not null,
  finished_at        timestamptz not null,
  duration_seconds   integer not null,
  time_limit_seconds integer not null,
  timed_out          boolean not null default false,
  score              integer not null,
  total              integer not null,
  answered           integer not null,
  by_paper           jsonb not null default '{}'::jsonb,
  answers            jsonb not null default '[]'::jsonb,
  created_at         timestamptz not null default now()
);
create index if not exists attempts_user_idx on public.attempts (user_id, started_at desc);

-- Row level security: each user can only see and change their own rows.
alter table public.progress enable row level security;
alter table public.attempts enable row level security;

drop policy if exists "own progress" on public.progress;
create policy "own progress" on public.progress
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "read own attempts" on public.attempts;
create policy "read own attempts" on public.attempts
  for select using (auth.uid() = user_id);

drop policy if exists "add own attempts" on public.attempts;
create policy "add own attempts" on public.attempts
  for insert with check (auth.uid() = user_id);

-- Let signed-in users reach these tables through the API (row level security above still applies).
grant select, insert, update, delete on public.progress to authenticated;
grant select, insert on public.attempts to authenticated;
