WITH container_ns AS (
  SELECT
    cc.id,
    cc.image,
    pn.pid_namespace
  FROM containerd_containers cc
  JOIN process_namespaces pn ON pn.pid = cc.pid
  WHERE cc.state = 'running'
    AND cc.image LIKE '%dvwa%'
    AND cc.socket_path = '/var/snap/microk8s/common/run/containerd.sock'
),
container_processes AS (
  SELECT
    SUBSTR(c.id, 1, 8) AS container_id,
    p.pid AS host_pid,
    p.parent AS host_parent,
    p.name,
    p.cmdline
  FROM container_ns c
  JOIN processes p ON 1=1
  JOIN process_namespaces pn ON pn.pid = p.pid
  WHERE pn.pid_namespace = c.pid_namespace
)
SELECT
  cp.container_id,
  cp.host_pid,
  cp.host_parent,
  cp.name,
  cp.cmdline,
  yp.matches
FROM container_processes cp
LEFT JOIN yara_process yp ON yp.pid = cp.host_pid AND yp.sigurl='https://fleet.hackinglab.local/api/osquery/yara/malware_rules.yar'
WHERE yp.count > 0
ORDER BY cp.host_pid;
