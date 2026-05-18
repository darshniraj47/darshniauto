# 🤖 GitHub Auto-Commit Bot

Daily **4 automatic commits** to keep your GitHub contribution heatmap green — fully automated using Windows Task Scheduler.

---

## 📅 Commit Schedule

| Task Name        | Time  |
|-----------------|-------|
| AutoCommit_9AM  | 09:00 |
| AutoCommit_1PM  | 13:00 |
| AutoCommit_6PM  | 18:00 |
| AutoCommit_10PM | 22:00 |

---

## 🚀 Setup Steps (One-Time Only)

### Step 1 — Create a GitHub Repo
1. Go to [github.com](https://github.com) → **New repository**
2. Name it (e.g., `daily-commits`)
3. Make it **Public** (so heatmap shows green dots)
4. Do **NOT** add README (we'll push from here)

---

### Step 2 — Run Git Setup
```
Double-click → setup_git.bat
```
Enter your GitHub username, email, and repo URL when asked.

---

### Step 3 — Schedule Auto-Commits
```
Right-click → Run as Administrator → setup_scheduler.bat
```
This creates 4 daily tasks in Windows Task Scheduler.

---

### Step 4 — Save GitHub Credentials
So git push works without a password prompt:
```
git config --global credential.helper manager
```
Then push once manually — Windows will save your token/password.

---

## 📁 Folder Structure

```
autocommit/
├── auto_commit.py       ← Main commit script (runs 4x/day)
├── setup_git.bat        ← One-time GitHub setup
├── setup_scheduler.bat  ← Schedules the 4 daily tasks
├── commit_log.txt       ← Auto-generated log of all commits
├── activity/
│   └── daily_tick.txt   ← File that changes each commit
└── README.md
```

---

## 🔧 Manage Tasks (optional)

| Action | Command |
|--------|---------|
| List all tasks | `schtasks /query /tn "AutoCommit*"` |
| Delete all tasks | Run `setup_scheduler.bat` again (it resets) |
| Test manually | `python auto_commit.py` |

---

## ⚠️ Requirements

- Python 3.x installed
- Git installed & configured
- PC must be ON at scheduled times
- GitHub credentials saved (no password prompt)

---

> Made with ❤️ — Stay consistent, keep the heatmap green! 🟩
