# LIRS Tax Exam Drill (static build)

A single-page study app: 1,577 questions across 7 papers, mock exam, misses, stars.
No build step. Everything is in index.html.

## Deploy to Vercel

Option A, no install: go to https://vercel.com/new, choose "Deploy" from a folder
(or drag this folder onto the Vercel dashboard), and deploy. Framework preset: Other.

Option B, CLI:
    npm i -g vercel
    cd lirs-exam-drill
    vercel          # first run links the project
    vercel --prod   # production URL

Option C, GitHub: push this folder to a repo, then import it at https://vercel.com/new.
Every push redeploys.

## What differs from the Claude version
- Progress, misses and stars are saved in the browser (localStorage), per device.
- AI "why it's correct / why you missed it" coaching and the AI weak-areas report are
  off. The built-in explanation under each answer and the score-by-paper report still work.
