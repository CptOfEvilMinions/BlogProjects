WITH RECURSIVE claude_tree(pid, name, path, cmdline, parent, uid, cwd, depth) AS (
  SELECT p.pid, p.name, p.path, p.cmdline, p.parent, p.uid, p.cwd, 0
  FROM processes p
  WHERE (p.name LIKE '%claude%' OR p.path LIKE '%claude-desktop%')
    AND p.parent NOT IN (
      SELECT pid FROM processes
      WHERE name LIKE '%claude%' OR path LIKE '%claude-desktop%'
    )
  UNION ALL
  SELECT c.pid, c.name, c.path, c.cmdline, c.parent, c.uid, c.cwd, ct.depth + 1
  FROM processes c
  JOIN claude_tree ct ON c.parent = ct.pid
),
claude_procs AS (
  SELECT pid, name, path, cmdline, parent, uid, cwd, depth
  FROM claude_tree
)
SELECT
  cp.pid, cp.name, cp.path, cp.cmdline, cp.parent, cp.uid, cp.cwd,
  cp.depth,
  yp.matches,
  yp.count
FROM claude_procs cp
LEFT JOIN yara_process yp ON yp.pid = cp.pid
    AND  yp.sigurl = 'https://fleet.hackinglab.local/api/osquery/yara/mcp_rules.yar'
WHERE yp.count > 0
ORDER BY cp.depth, cp.pid;
