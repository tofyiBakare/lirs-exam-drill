# LIRS Tax Exam Drill

A single-page study app: 1,577 questions across 7 papers. Mock exam (100 questions, 30 minutes),
shuffled and in-order practice, misses, stars, and a history of every mock exam attempt.
No build step: everything is in `index.html`.

## Sign-in setup (Supabase, free tier)

1. Create a project at https://supabase.com.
2. SQL Editor → New query → paste `supabase.sql` → Run. This creates the `progress` and
   `attempts` tables, with rules so each user only sees their own data.
3. Authentication → URL Configuration: set **Site URL** to your Vercel URL
   (e.g. https://lirs-exam-drill.vercel.app). Add it under **Redirect URLs** too.
   Confirmation and password-reset emails link back here.
4. Project Settings → API: copy the **Project URL** and the **anon public** key into `config.js`.
5. Commit and push. Vercel redeploys.

Without step 4 the app still works, but progress is saved on each device only.

Optional: to stop strangers creating accounts, turn off "Allow new users to sign up"
(Authentication → Sign In / Providers → Email) after your users have signed up, or invite them
from Authentication → Users.

## Where data lives

- `progress`: one row per user. Running record of every question answered, misses, stars,
  and a summary of each mock exam.
- `attempts`: one row per mock exam: start and finish time, time used, whether time ran out,
  score, total, score by paper, and each answer given.

## Deploy updates

Push to `main`. Vercel redeploys to the same URL.
