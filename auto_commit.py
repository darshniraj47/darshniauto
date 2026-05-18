import subprocess
import datetime
import os
import random

# ─────────────────────────────────────────────
#  AUTO COMMIT SCRIPT
#  Runs 4x per day via Windows Task Scheduler
#  Each run = 1 commit to GitHub
# ─────────────────────────────────────────────

import sys

# Reconfigure stdout/stderr to UTF-8 for safe emoji printing in Windows Console
if hasattr(sys.stdout, 'reconfigure'):
    sys.stdout.reconfigure(encoding='utf-8')
if hasattr(sys.stderr, 'reconfigure'):
    sys.stderr.reconfigure(encoding='utf-8')

# Get current directory (where this script lives)
REPO_DIR = os.path.dirname(os.path.abspath(__file__))
LOG_FILE  = os.path.join(REPO_DIR, "commit_log.txt")
TICK_FILE = os.path.join(REPO_DIR, "activity", "daily_tick.txt")

# Motivational messages for commit messages
MESSAGES = [
    "Daily progress update",
    "Consistency is key",
    "Another step forward",
    "Keeping the streak alive",
    "Growth mindset activated",
    "Daily commit done",
    "Staying on track",
    "Small steps, big results",
    "No days off",
    "Building habits daily",
    "System update",
    "Progress over perfection",
]

def run(cmd, cwd=None):
    """Run a shell command and return output."""
    result = subprocess.run(
        cmd, shell=True, cwd=cwd or REPO_DIR,
        capture_output=True, text=True, encoding='utf-8', errors='ignore'
    )
    return result.returncode, result.stdout.strip(), result.stderr.strip()

def log(message):
    """Append a message to the log file."""
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    entry = f"[{now}] {message}"
    try:
        print(entry)
    except UnicodeEncodeError:
        # Fallback if console still complains
        print(entry.encode('ascii', 'ignore').decode('ascii'))
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(entry + "\n")

def make_commit():
    now = datetime.datetime.now()
    date_str  = now.strftime("%Y-%m-%d")
    time_str  = now.strftime("%H:%M:%S")

    # ── 1. Update the activity tick file ──────────────────────
    os.makedirs(os.path.dirname(TICK_FILE), exist_ok=True)
    with open(TICK_FILE, "a", encoding="utf-8") as f:
        f.write(f"{date_str} {time_str} | auto-commit\n")

    # ── 2. Stage the change ────────────────────────────────────
    code, out, err = run("git add .")
    if code != 0:
        log(f"❌ git add failed: {err}")
        return False

    # ── 3. Commit with a random motivational message ───────────
    msg = random.choice(MESSAGES)
    commit_msg = f"{msg} [{date_str} {time_str}]"
    code, out, err = run(f'git commit -m "{commit_msg}"')
    if code != 0:
        log(f"⚠️  git commit failed (maybe nothing to commit): {err}")
        return False

    # ── 4. Try to Push to GitHub ───────────────────────────────
    # If offline, the commit stays locally. The next time they are online, 
    # Git will push ALL stacked commits and their heatmap will get filled correctly!
    code, out, err = run("git push")
    if code != 0:
        log(f"📡 Offline Mode: Commit saved locally. Will sync to GitHub when internet is back! (Error: {err})")
        return True # Return true because commit succeeded locally!

    log(f"✅ Online Mode: Commit pushed successfully to GitHub → {commit_msg}")
    return True

if __name__ == "__main__":
    log("=" * 55)
    log("🤖 Auto-commit script started")
    make_commit()
    log("🤖 Auto-commit script finished")
    log("=" * 55)
