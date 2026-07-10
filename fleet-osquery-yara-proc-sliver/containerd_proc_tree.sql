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
)
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
ORDER BY p.pid;
