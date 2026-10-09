#!/usr/bin/env bash
# Runs a spec-diff tool over every case and scores it against case.json.
# Default tool: oasdiff (https://github.com/oasdiff/oasdiff), must be on PATH.
# Any other tool: set TOOL_CMD to a command that takes BEFORE AFTER and exits
# non-zero (and prints at least one line) when it reports a breaking change.
# Usage: scripts/run.sh            -> prints a per-case table and totals
set -u
cd "$(dirname "$0")/.."
TOOL_CMD=${TOOL_CMD:-"oasdiff breaking --fail-on ERR"}
python3 - "$TOOL_CMD" <<'PY'
import json, glob, subprocess, sys, shlex
cmd = shlex.split(sys.argv[1])
tp = fp = tn = fn = 0
print(f"{'case':42} {'expected':9} {'tool':9} result")
for d in sorted(glob.glob("cases/*/")):
    case = json.load(open(d + "case.json"))
    exp = case["expected"]["breaking"]
    r = subprocess.run(cmd + [d + "before.yaml", d + "after.yaml"], capture_output=True, text=True)
    got = r.returncode != 0
    res = "ok" if got == exp else ("MISSED" if exp else "FALSE ALARM")
    tp += got and exp; fp += got and not exp; tn += (not got) and (not exp); fn += (not got) and exp
    print(f"{case['id']:42} {str(exp):9} {str(got):9} {res}")
print(f"\ncases={tp+fp+tn+fn} caught={tp} missed={fn} false_alarms={fp} correct_negatives={tn}")
print("Scope: breaking yes/no per case only. Affected-consumer scoring is not automated yet.")
PY
