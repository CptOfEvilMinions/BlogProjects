
-- Table: hmail_app | CIM Model: Email
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`hmail_app` AS
SELECT
        `hostname` AS `host`,
        `ts` AS `_time`,
        `service` AS `service`,
        `session_id` AS `internal_message_id`,
        `client_ip` AS `src`,
        `message` AS `message`
FROM btv_dc30.silver.`hmail_app`;


-- Table: hmail_imapd | CIM Model: Email
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`hmail_imapd` AS
SELECT
        `hostname` AS `host`,
        `ts` AS `_time`,
        `service` AS `service`,
        `session_id` AS `internal_message_id`,
        `client_ip` AS `src`,
        `message` AS `message`
FROM btv_dc30.silver.`hmail_imapd`;


-- Table: hmail_smtp | CIM Model: Email
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`hmail_smtp` AS
SELECT
        `hostname` AS `host`,
        `ts` AS `_time`,
        `sender` AS `src_user`,
        `recipient` AS `recipient`,
        `client_ip` AS `src`,
        `server_ip` AS `dest`,
        `protocol` AS `protocol`,
        `status_code` AS `status_code`,
        `session_id` AS `session_id`
FROM btv_dc30.silver.`hmail_smtp`;


-- Table: hmail_smtpd | CIM Model: Email
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`hmail_smtpd` AS
SELECT
        `hostname` AS `host`,
        `ts` AS `_time`,
        `service` AS `service`,
        `client_ip` AS `src`,
        `message` AS `message`
FROM btv_dc30.silver.`hmail_smtpd`;


-- Table: hmail_tcpip | CIM Model: Email
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`hmail_tcpip` AS
SELECT
        `hostname` AS `src`,
        `ts` AS `_time`,
        `service` AS `service`,
        `message` AS `message`
FROM btv_dc30.silver.`hmail_tcpip`;


-- Table: osquery_cpu_time | CIM Model: Performance
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_cpu_time` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `core` AS `core`,
        `guest` AS `guest`,
        `guest_nice` AS `guest_nice`,
        `idle` AS `idle`,
        `iowait` AS `iowait`,
        `irq` AS `irq`,
        `nice` AS `nice`,
        `softirq` AS `softirq`,
        `steal` AS `steal`,
        `system` AS `system`,
        `user` AS `user`
FROM btv_dc30.silver.`osquery_cpu_time`;


-- Table: osquery_device_nodes | CIM Model: Change
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_device_nodes` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change_type`,
        `atime` AS `atime`,
        `block_size` AS `block_size`,
        `ctime` AS `ctime`,
        `gid` AS `gid`,
        `mode` AS `mode`,
        `mtime` AS `mtime`,
        `path` AS `file_path`,
        `type` AS `file_type`,
        `uid` AS `uid`
FROM btv_dc30.silver.`osquery_device_nodes`;


-- Table: osquery_iptables | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_iptables` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `dvc`,
        `change` AS `action`,
        `bytes` AS `bytes`,
        `chain` AS `chain`,
        `dst_ip` AS `dest_ip`,
        `dst_mask` AS `dst_mask`,
        `dst_port` AS `dest_port`,
        `filter_name` AS `filter_name`,
        `iniface` AS `src_interface`,
        `iniface_mask` AS `iniface_mask`,
        `match` AS `match`,
        `outiface` AS `dest_interface`,
        `outiface_mask` AS `outiface_mask`,
        `packets` AS `packets`,
        `policy` AS `policy`,
        `protocol` AS `protocol`,
        `src_ip` AS `src_ip`,
        `src_mask` AS `src_mask`,
        `src_port` AS `src_port`,
        `target` AS `target`
FROM btv_dc30.silver.`osquery_iptables`;


-- Table: osquery_kernel_modules | CIM Model: Change
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_kernel_modules` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change_type`,
        `address` AS `address`,
        `name` AS `name`,
        `size` AS `size`,
        `status` AS `status`,
        `used_by` AS `used_by`
FROM btv_dc30.silver.`osquery_kernel_modules`;


-- Table: osquery_last | CIM Model: Authentication
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_last` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `src`,
        `change` AS `change`,
        `host` AS `dest`,
        `pid` AS `pid`,
        `time` AS `time`,
        `tty` AS `tty`,
        `type` AS `type`,
        `type_name` AS `type_name`,
        `username` AS `user`
FROM btv_dc30.silver.`osquery_last`;


-- Table: osquery_listening_ports | CIM Model: Network Sessions
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_listening_ports` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `address` AS `src_ip`,
        `family` AS `family`,
        `fd` AS `fd`,
        `net_namespace` AS `net_namespace`,
        `path` AS `path`,
        `pid` AS `pid`,
        `port` AS `src_port`,
        `protocol` AS `protocol`,
        `socket` AS `socket`
FROM btv_dc30.silver.`osquery_listening_ports`;


-- Table: osquery_logged_in_users | CIM Model: Authentication
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_logged_in_users` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `src`,
        `change` AS `change`,
        `cmdline` AS `cmdline`,
        `cwd` AS `cwd`,
        `host` AS `dest`,
        `name` AS `name`,
        `pid` AS `pid`,
        `root` AS `root`,
        `time` AS `time`,
        `tty` AS `tty`,
        `type` AS `type`,
        `user` AS `user`
FROM btv_dc30.silver.`osquery_logged_in_users`;


-- Table: osquery_memory_info | CIM Model: Performance
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_memory_info` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `active` AS `active`,
        `buffers` AS `buffers`,
        `cached` AS `cached`,
        `inactive` AS `inactive`,
        `memory_free` AS `memory_free`,
        `memory_total` AS `memory_total`,
        `swap_cached` AS `swap_cached`,
        `swap_free` AS `swap_free`,
        `swap_total` AS `swap_total`
FROM btv_dc30.silver.`osquery_memory_info`;


-- Table: osquery_mounts | CIM Model: Inventory
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_mounts` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `blocks` AS `blocks`,
        `blocks_available` AS `blocks_available`,
        `blocks_free` AS `blocks_free`,
        `blocks_size` AS `blocks_size`,
        `device` AS `device`,
        `device_alias` AS `device_alias`,
        `flags` AS `flags`,
        `inodes` AS `inodes`,
        `inodes_free` AS `inodes_free`,
        `path` AS `path`,
        `type` AS `type`
FROM btv_dc30.silver.`osquery_mounts`;


-- Table: osquery_open_sockets | CIM Model: Network Sessions
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_open_sockets` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `family` AS `family`,
        `local_address` AS `src`,
        `local_port` AS `src_port`,
        `path` AS `path`,
        `pid` AS `pid`,
        `protocol` AS `protocol`,
        `remote_address` AS `dest`,
        `remote_port` AS `dest_port`
FROM btv_dc30.silver.`osquery_open_sockets`;


-- Table: osquery_osquery_info | CIM Model: Inventory
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_osquery_info` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `build_distro` AS `build_distro`,
        `build_platform` AS `build_platform`,
        `config_hash` AS `config_hash`,
        `config_valid` AS `enabled`,
        `counter` AS `counter`,
        `extensions` AS `extensions`,
        `instance_id` AS `instance_id`,
        `pid` AS `pid`,
        `platform_mask` AS `platform_mask`,
        `resident_size` AS `resident_size`,
        `start_time` AS `start_time`,
        `system_time` AS `system_time`,
        `user_time` AS `user_time`,
        `uuid` AS `serial`,
        `version` AS `version`,
        `watcher` AS `watcher`
FROM btv_dc30.silver.`osquery_osquery_info`;


-- Table: osquery_process_events | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_process_events` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `dest`,
        `change` AS `action`,
        `auid` AS `user`,
        `cmdline` AS `cmdline`,
        `ctime` AS `ctime`,
        `cwd` AS `cwd`,
        `egid` AS `egid`,
        `euid` AS `euid`,
        `gid` AS `gid`,
        `parent` AS `parent`,
        `path` AS `object_path`,
        `pid` AS `pid`,
        `time` AS `time`,
        `uid` AS `uid`
FROM btv_dc30.silver.`osquery_process_events`;


-- Table: osquery_runtime_perf | CIM Model: Performance
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_runtime_perf` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `build_distro` AS `build_distro`,
        `build_platform` AS `build_platform`,
        `config_hash` AS `config_hash`,
        `config_valid` AS `config_valid`,
        `counter` AS `counter`,
        `database_size` AS `database_size`,
        `extensions` AS `extensions`,
        `instance_id` AS `instance_id`,
        `os_codename` AS `os_codename`,
        `os_platform` AS `os_platform`,
        `os_version` AS `os_version`,
        `pid` AS `pid`,
        `platform_mask` AS `platform_mask`,
        `resident_size` AS `resident_size`,
        `start_time` AS `start_time`,
        `system_time` AS `system_time`,
        `user_time` AS `user_time`,
        `uuid` AS `uuid`,
        `version` AS `version`,
        `watcher` AS `watcher`
FROM btv_dc30.silver.`osquery_runtime_perf`;


-- Table: osquery_schedule | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_schedule` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `action`,
        `average_memory` AS `average_memory`,
        `avg_system_time` AS `avg_system_time`,
        `avg_user_time` AS `avg_user_time`,
        `denylisted` AS `denylisted`,
        `executions` AS `executions`,
        `interval` AS `interval`,
        `last_executed` AS `last_executed`,
        `name` AS `object`,
        `output_size` AS `output_size`,
        `wall_time` AS `wall_time`
FROM btv_dc30.silver.`osquery_schedule`;


-- Table: osquery_smbios_tables | CIM Model: Inventory
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_smbios_tables` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `description` AS `description`,
        `handle` AS `handle`,
        `header_size` AS `header_size`,
        `md5` AS `md5`,
        `number` AS `number`,
        `size` AS `size`,
        `type` AS `type`
FROM btv_dc30.silver.`osquery_smbios_tables`;


-- Table: osquery_socket_events | CIM Model: Network Sessions
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_socket_events` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change`,
        `action` AS `action`,
        `auid` AS `auid`,
        `family` AS `family`,
        `local_address` AS `src`,
        `local_port` AS `src_port`,
        `path` AS `path`,
        `pid` AS `pid`,
        `remote_address` AS `dest`,
        `remote_port` AS `dest_port`,
        `success` AS `success`,
        `time` AS `duration`
FROM btv_dc30.silver.`osquery_socket_events`;


-- Table: osquery_syslog_events | CIM Model: Change
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`osquery_syslog_events` AS
SELECT
        `ts` AS `_time`,
        `hostname` AS `host`,
        `change` AS `change_type`,
        `datetime` AS `datetime`,
        `facility` AS `facility`,
        `message` AS `message`,
        `severity` AS `severity`,
        `tag` AS `tag`,
        `time` AS `time`
FROM btv_dc30.silver.`osquery_syslog_events`;


-- Table: sysmon_clipboardchange | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_clipboardchange` AS
SELECT
        `event` AS `action`,
        `hash` AS `hash`,
        `process` AS `process`,
        `related` AS `related`,
        `sysmon` AS `sysmon`,
        `user` AS `user`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `dest`,
        `process_name` AS `process_exec`,
        `username` AS `username`
FROM btv_dc30.silver.`sysmon_clipboardchange`;


-- Table: sysmon_createremotethread | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_createremotethread` AS
SELECT
        `event` AS `event`,
        `host` AS `dest`,
        `process` AS `process`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_createremotethread`;


-- Table: sysmon_dnseventdnsquery | CIM Model: Network Resolution (DNS)
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_dnseventdnsquery` AS
SELECT
        `dns` AS `query`,
        `event` AS `name`,
        `host` AS `dest`,
        `network` AS `network`,
        `process` AS `process`,
        `sysmon` AS `sysmon`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `host`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_dnseventdnsquery`;


-- Table: sysmon_driverloaded | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_driverloaded` AS
SELECT
        `event` AS `action`,
        `file` AS `object_path`,
        `hash` AS `hash`,
        `host` AS `dest`,
        `related` AS `related`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `host`,
        `filename` AS `object`
FROM btv_dc30.silver.`sysmon_driverloaded`;


-- Table: sysmon_error | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_error` AS
SELECT
        `error` AS `error`,
        `event` AS `event`,
        `host` AS `host`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`
FROM btv_dc30.silver.`sysmon_error`;


-- Table: sysmon_filecreate | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_filecreate` AS
SELECT
        `event` AS `action`,
        `file` AS `object`,
        `host` AS `dest`,
        `process` AS `process`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `timestamp`,
        `hostname` AS `hostname`,
        `filename` AS `object_path`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_filecreate`;


-- Table: sysmon_filecreatestreamhash | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_filecreatestreamhash` AS
SELECT
        `event` AS `action`,
        `file` AS `object_path`,
        `hash` AS `hash`,
        `host` AS `dest`,
        `process` AS `process`,
        `related` AS `related`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `filename` AS `object`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_filecreatestreamhash`;


-- Table: sysmon_imageloaded | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_imageloaded` AS
SELECT
        `event` AS `event`,
        `file` AS `object`,
        `hash` AS `hash`,
        `host` AS `dest`,
        `process` AS `process`,
        `related` AS `related`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `filename` AS `object_path`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_imageloaded`;


-- Table: sysmon_networkconnection | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_networkconnection` AS
SELECT
        `destination` AS `dest_ip`,
        `event` AS `signature_id`,
        `host` AS `src`,
        `network` AS `network`,
        `process` AS `process`,
        `related` AS `related`,
        `rule` AS `rule`,
        `source` AS `src_ip`,
        `user` AS `user`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `process_name` AS `process_name`,
        `username` AS `username`
FROM btv_dc30.silver.`sysmon_networkconnection`;


-- Table: sysmon_pipeeventpipeconnected | CIM Model: Interprocess Messaging
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_pipeeventpipeconnected` AS
SELECT
        `event` AS `event`,
        `file` AS `file`,
        `host` AS `host`,
        `process` AS `process`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `request_sent_time`,
        `hostname` AS `hostname`,
        `filename` AS `filename`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_pipeeventpipeconnected`;


-- Table: sysmon_pipeeventpipecreated | CIM Model: Interprocess Messaging
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_pipeeventpipecreated` AS
SELECT
        `event` AS `message`,
        `file` AS `file`,
        `host` AS `host`,
        `process` AS `process`,
        `winlog` AS `winlog`,
        `ts` AS `request_sent_time`,
        `hostname` AS `hostname`,
        `filename` AS `filename`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_pipeeventpipecreated`;


-- Table: sysmon_processaccess | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_processaccess` AS
SELECT
        `event` AS `action`,
        `host` AS `dest`,
        `process` AS `object`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `process_name` AS `object_path`
FROM btv_dc30.silver.`sysmon_processaccess`;


-- Table: sysmon_processchangedafilecreationtime | CIM Model: Change
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_processchangedafilecreationtime` AS
SELECT
        `event` AS `event`,
        `file` AS `file`,
        `host` AS `host`,
        `process` AS `process`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `dest_host`,
        `filename` AS `file_name`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_processchangedafilecreationtime`;


-- Table: sysmon_processcreation | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_processcreation` AS
SELECT
        `event` AS `event`,
        `hash` AS `hash`,
        `host` AS `dest`,
        `process` AS `process`,
        `related` AS `related`,
        `rule` AS `rule`,
        `user` AS `user`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `process_name` AS `object`,
        `username` AS `username`
FROM btv_dc30.silver.`sysmon_processcreation`;


-- Table: sysmon_processtampering | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_processtampering` AS
SELECT
        `event` AS `event`,
        `host` AS `host`,
        `process` AS `process`,
        `related` AS `related`,
        `user` AS `user`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `process_name` AS `process_name`,
        `username` AS `username`
FROM btv_dc30.silver.`sysmon_processtampering`;


-- Table: sysmon_processterminated | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_processterminated` AS
SELECT
        `event` AS `event`,
        `host` AS `dest`,
        `process` AS `process`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_processterminated`;


-- Table: sysmon_registryeventobjectcreateanddelete | CIM Model: Change
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_registryeventobjectcreateanddelete` AS
SELECT
        `event` AS `event`,
        `host` AS `host`,
        `process` AS `process`,
        `registry` AS `registry`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `registry_path` AS `registry_path`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_registryeventobjectcreateanddelete`;


-- Table: sysmon_registryeventvalueset | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_registryeventvalueset` AS
SELECT
        `event` AS `action`,
        `host` AS `dest`,
        `process` AS `process`,
        `registry` AS `object`,
        `rule` AS `rule`,
        `winlog` AS `winlog`,
        `ts` AS `ts`,
        `hostname` AS `hostname`,
        `registry_path` AS `object_path`,
        `process_name` AS `process_name`
FROM btv_dc30.silver.`sysmon_registryeventvalueset`;


-- Table: sysmon_sysmonservicestatechanged | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`sysmon_sysmonservicestatechanged` AS
SELECT
        `event` AS `action`,
        `host` AS `dest`,
        `winlog` AS `object`,
        `ts` AS `ts`,
        `hostname` AS `hostname`
FROM btv_dc30.silver.`sysmon_sysmonservicestatechanged`;


-- Table: wineventlogs_application | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`wineventlogs_application` AS
SELECT
        `event` AS `event`,
        `host` AS `dest`,
        `message` AS `message`,
        `ts` AS `ts`,
        `hostname` AS `hostname`,
        `channel` AS `channel`,
        `event_data` AS `event_data`,
        `event_id` AS `event_id`,
        `keywords` AS `keywords`,
        `opcode` AS `opcode`,
        `process` AS `process`,
        `provider_guid` AS `provider_guid`,
        `provider_name` AS `provider_name`,
        `record_id` AS `record_id`,
        `task` AS `task`,
        `user` AS `user`,
        `user_data` AS `user_data`,
        `version` AS `version`
FROM btv_dc30.silver.`wineventlogs_application`;


-- Table: wineventlogs_microsoft_windows_powershell | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`wineventlogs_microsoft_windows_powershell` AS
SELECT
        `event` AS `event`,
        `host` AS `dest`,
        `message` AS `message`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `activity_id` AS `activity_id`,
        `channel` AS `channel`,
        `event_data` AS `event_data`,
        `event_id` AS `event_id`,
        `opcode` AS `opcode`,
        `process` AS `process`,
        `provider_guid` AS `provider_guid`,
        `provider_name` AS `provider_name`,
        `record_id` AS `record_id`,
        `task` AS `task`,
        `user` AS `user`,
        `version` AS `version`
FROM btv_dc30.silver.`wineventlogs_microsoft_windows_powershell`;


-- Table: wineventlogs_microsoft_windows_smbserver | CIM Model: Network Sessions
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`wineventlogs_microsoft_windows_smbserver` AS
SELECT
        `event` AS `signature`,
        `host` AS `src_dns`,
        `message` AS `message`,
        `ts` AS `_time`,
        `hostname` AS `host`,
        `channel` AS `channel`,
        `event_id` AS `signature_id`,
        `opcode` AS `opcode`,
        `process` AS `process`,
        `provider_guid` AS `provider_guid`,
        `provider_name` AS `provider_name`,
        `record_id` AS `record_id`,
        `user` AS `user`,
        `user_data` AS `user_data`
FROM btv_dc30.silver.`wineventlogs_microsoft_windows_smbserver`;


-- Table: wineventlogs_microsoft_windows_sysmon | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`wineventlogs_microsoft_windows_sysmon` AS
SELECT
        `error` AS `status`,
        `event` AS `action`,
        `host` AS `dest`,
        `message` AS `message`,
        `ts` AS `_time`,
        `hostname` AS `host`,
        `channel` AS `source`,
        `event_data` AS `object`,
        `event_id` AS `event_id`,
        `opcode` AS `opcode`,
        `process` AS `process`,
        `provider_guid` AS `provider_guid`,
        `provider_name` AS `provider_name`,
        `record_id` AS `record_id`,
        `task` AS `task`,
        `user` AS `user`,
        `version` AS `version`
FROM btv_dc30.silver.`wineventlogs_microsoft_windows_sysmon`;


-- Table: wineventlogs_microsoft_windows_terminalservices_localsessionmanager | CIM Model: Authentication
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`wineventlogs_microsoft_windows_terminalservices_localsessionmanager` AS
SELECT
        `error` AS `error`,
        `event` AS `event`,
        `host` AS `dest`,
        `message` AS `message`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `activity_id` AS `activity_id`,
        `channel` AS `channel`,
        `event_data` AS `event_data`,
        `event_id` AS `event_id`,
        `opcode` AS `opcode`,
        `process` AS `process`,
        `provider_guid` AS `provider_guid`,
        `provider_name` AS `provider_name`,
        `record_id` AS `record_id`,
        `user` AS `user`,
        `user_data` AS `user_data`
FROM btv_dc30.silver.`wineventlogs_microsoft_windows_terminalservices_localsessionmanager`;


-- Table: wineventlogs_microsoft_windows_terminalservices_remoteconnectionmanager | CIM Model: Authentication
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`wineventlogs_microsoft_windows_terminalservices_remoteconnectionmanager` AS
SELECT
        `event` AS `event`,
        `host` AS `dest`,
        `message` AS `message`,
        `ts` AS `_time`,
        `hostname` AS `hostname`,
        `activity_id` AS `activity_id`,
        `channel` AS `channel`,
        `event_id` AS `event_id`,
        `opcode` AS `opcode`,
        `process` AS `process`,
        `provider_guid` AS `provider_guid`,
        `provider_name` AS `provider_name`,
        `record_id` AS `record_id`,
        `user` AS `user`,
        `user_data` AS `user_data`
FROM btv_dc30.silver.`wineventlogs_microsoft_windows_terminalservices_remoteconnectionmanager`;


-- Table: zeek_cluster | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_cluster` AS
SELECT
        `message` AS `message`,
        `node` AS `hostname`,
        `ts` AS `_time`
FROM btv_dc30.silver.`zeek_cluster`;


-- Table: zeek_conn | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_conn` AS
SELECT
        `community_id` AS `community_id`,
        `conn_state` AS `conn_state`,
        `duration` AS `duration`,
        `history` AS `tcp_flag`,
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest_ip`,
        `dest_port` AS `dest_port`,
        `local_orig` AS `local_src`,
        `local_resp` AS `local_dest`,
        `missed_bytes` AS `missed_bytes`,
        `orig_bytes` AS `bytes_out`,
        `orig_ip_bytes` AS `src_ip_bytes`,
        `orig_pkts` AS `packets_out`,
        `proto` AS `proto`,
        `resp_bytes` AS `bytes_in`,
        `resp_ip_bytes` AS `dest_ip_bytes`,
        `resp_pkts` AS `packets_in`,
        `service` AS `service`,
        `ts` AS `timestamp`,
        `tunnel_parents` AS `tunnel_parents`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_conn`;


-- Table: zeek_dce_rpc | CIM Model: Network Sessions
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_dce_rpc` AS
SELECT
        `endpoint` AS `endpoint`,
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest_ip`,
        `dest_port` AS `dest_port`,
        `named_pipe` AS `named_pipe`,
        `operation` AS `operation`,
        `rtt` AS `response_time`,
        `ts` AS `timestamp`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_dce_rpc`;


-- Table: zeek_dns | CIM Model: Network Resolution (DNS)
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_dns` AS
SELECT
        `AA` AS `AA`,
        `RA` AS `RA`,
        `RD` AS `RD`,
        `TC` AS `TC`,
        `TTLs` AS `ttl`,
        `Z` AS `Z`,
        `answers` AS `answer`,
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `proto` AS `proto`,
        `qclass` AS `qclass`,
        `qclass_name` AS `qclass_name`,
        `qtype` AS `query_type`,
        `qtype_name` AS `qtype_name`,
        `query` AS `query`,
        `rcode` AS `rcode`,
        `rcode_name` AS `rcode_name`,
        `rejected` AS `rejected`,
        `rtt` AS `duration`,
        `trans_id` AS `transaction_id`,
        `ts` AS `ts`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_dns`;


-- Table: zeek_dpd | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_dpd` AS
SELECT
        `analyzer` AS `analyzer`,
        `failure_reason` AS `failure_reason`,
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest_ip`,
        `dest_port` AS `dest_port`,
        `proto` AS `proto`,
        `ts` AS `_time`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_dpd`;


-- Table: zeek_files | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_files` AS
SELECT
        `analyzers` AS `analyzers`,
        `conn_uids` AS `conn_uids`,
        `depth` AS `depth`,
        `duration` AS `duration`,
        `extracted` AS `extracted`,
        `extracted_cutoff` AS `extracted_cutoff`,
        `filename` AS `filename`,
        `fuid` AS `fuid`,
        `is_orig` AS `is_orig`,
        `local_orig` AS `local_orig`,
        `md5` AS `md5`,
        `mime_type` AS `mime_type`,
        `missing_bytes` AS `missing_bytes`,
        `overflow_bytes` AS `overflow_bytes`,
        `rx_hosts` AS `rx_hosts`,
        `seen_bytes` AS `bytes_in`,
        `sha1` AS `sha1`,
        `sha256` AS `sha256`,
        `source` AS `source`,
        `timedout` AS `timedout`,
        `total_bytes` AS `bytes`,
        `ts` AS `_time`,
        `tx_hosts` AS `tx_hosts`
FROM btv_dc30.silver.`zeek_files`;


-- Table: zeek_http | CIM Model: Web
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_http` AS
SELECT
        `host` AS `host`,
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `info_code` AS `info_code`,
        `info_msg` AS `info_msg`,
        `method` AS `http_method`,
        `orig_filenames` AS `orig_filenames`,
        `orig_fuids` AS `orig_fuids`,
        `orig_mime_types` AS `http_content_type`,
        `request_body_len` AS `request_body_len`,
        `resp_filenames` AS `resp_filenames`,
        `resp_fuids` AS `resp_fuids`,
        `resp_mime_types` AS `resp_mime_types`,
        `response_body_len` AS `response_body_len`,
        `status_code` AS `status`,
        `status_msg` AS `status_msg`,
        `tags` AS `tags`,
        `trans_depth` AS `trans_depth`,
        `ts` AS `_time`,
        `uid` AS `uid`,
        `uri` AS `url`,
        `user_agent` AS `http_user_agent`,
        `username` AS `user`,
        `version` AS `version`
FROM btv_dc30.silver.`zeek_http`;


-- Table: zeek_kerberos | CIM Model: Authentication
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_kerberos` AS
SELECT
        `cipher` AS `cipher`,
        `client` AS `src_host`,
        `error_msg` AS `error_msg`,
        `forwardable` AS `forwardable`,
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `renewable` AS `renewable`,
        `request_type` AS `request_type`,
        `service` AS `service`,
        `success` AS `success`,
        `till` AS `till`,
        `ts` AS `ts`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_kerberos`;


-- Table: zeek_known_certs | CIM Model: Certificates
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_known_certs` AS
SELECT
        `host` AS `dest`,
        `issuer_subject` AS `ssl_issuer`,
        `port_num` AS `dest_port`,
        `serial` AS `serial`,
        `subject` AS `ssl_subject`,
        `ts` AS `_time`
FROM btv_dc30.silver.`zeek_known_certs`;


-- Table: zeek_known_services | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_known_services` AS
SELECT
        `host` AS `hostname`,
        `port_num` AS `dest_port`,
        `port_proto` AS `transport`,
        `service` AS `app`,
        `ts` AS `_time`
FROM btv_dc30.silver.`zeek_known_services`;


-- Table: zeek_notice | CIM Model: Intrusion Detection
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_notice` AS
SELECT
        `actions` AS `action`,
        `fuid` AS `fuid`,
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `msg` AS `signature`,
        `note` AS `note`,
        `p` AS `p`,
        `peer_descr` AS `peer_descr`,
        `proto` AS `proto`,
        `sub` AS `sub`,
        `suppress_for` AS `suppress_for`,
        `ts` AS `_time`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_notice`;


-- Table: zeek_ntlm | CIM Model: Authentication
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_ntlm` AS
SELECT
        `domainname` AS `domainname`,
        `hostname` AS `host`,
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `server_dns_computer_name` AS `server_dns_computer_name`,
        `server_nb_computer_name` AS `server_nb_computer_name`,
        `server_tree_name` AS `server_tree_name`,
        `success` AS `success`,
        `ts` AS `_time`,
        `uid` AS `uid`,
        `username` AS `user`
FROM btv_dc30.silver.`zeek_ntlm`;


-- Table: zeek_ntp | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_ntp` AS
SELECT
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest_ip`,
        `dest_port` AS `dest_port`,
        `mode` AS `mode`,
        `num_exts` AS `num_exts`,
        `org_time` AS `org_time`,
        `poll` AS `poll`,
        `precision` AS `precision`,
        `rec_time` AS `rec_time`,
        `ref_id` AS `ref_id`,
        `ref_time` AS `ref_time`,
        `root_delay` AS `root_delay`,
        `root_disp` AS `root_disp`,
        `stratum` AS `stratum`,
        `ts` AS `_time`,
        `uid` AS `uid`,
        `version` AS `version`,
        `xmt_time` AS `xmt_time`
FROM btv_dc30.silver.`zeek_ntp`;


-- Table: zeek_pe | CIM Model: Endpoint
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_pe` AS
SELECT
        `compile_ts` AS `compile_ts`,
        `has_cert_table` AS `has_cert_table`,
        `has_debug_data` AS `has_debug_data`,
        `has_export_table` AS `has_export_table`,
        `has_import_table` AS `has_import_table`,
        `id` AS `id`,
        `is_64bit` AS `is_64bit`,
        `is_exe` AS `is_exe`,
        `machine` AS `machine`,
        `os` AS `os`,
        `section_names` AS `section_names`,
        `subsystem` AS `subsystem`,
        `ts` AS `_time`,
        `uses_aslr` AS `uses_aslr`,
        `uses_code_integrity` AS `uses_code_integrity`,
        `uses_dep` AS `uses_dep`,
        `uses_seh` AS `uses_seh`
FROM btv_dc30.silver.`zeek_pe`;


-- Table: zeek_rdp | CIM Model: Network Sessions
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_rdp` AS
SELECT
        `cert_count` AS `cert_count`,
        `cookie` AS `cookie`,
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `result` AS `action`,
        `security_protocol` AS `security_protocol`,
        `ts` AS `_time`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_rdp`;


-- Table: zeek_reporter | CIM Model: Alerts
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_reporter` AS
SELECT
        `level` AS `severity_id`,
        `location` AS `location`,
        `message` AS `description`,
        `ts` AS `_time`
FROM btv_dc30.silver.`zeek_reporter`;


-- Table: zeek_smb_files | CIM Model: Data Access
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_smb_files` AS
SELECT
        `action` AS `action`,
        `fuid` AS `fuid`,
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `name` AS `object`,
        `path` AS `file_path`,
        `prev_name` AS `object_path`,
        `size` AS `object_size`,
        `times.accessed` AS `file_access_time`,
        `times.changed` AS `file_change_time`,
        `times.created` AS `file_create_time`,
        `times.modified` AS `file_modify_time`,
        `ts` AS `_time`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_smb_files`;


-- Table: zeek_smb_mapping | CIM Model: Network Sessions
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_smb_mapping` AS
SELECT
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `path` AS `path`,
        `share_type` AS `share_type`,
        `ts` AS `_time`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_smb_mapping`;


-- Table: zeek_smtp | CIM Model: Email
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_smtp` AS
SELECT
        `cc` AS `cc`,
        `date` AS `date`,
        `from` AS `src_user`,
        `fuids` AS `fuids`,
        `helo` AS `helo`,
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `in_reply_to` AS `in_reply_to`,
        `is_webmail` AS `is_webmail`,
        `last_reply` AS `last_reply`,
        `mailfrom` AS `mailfrom`,
        `msg_id` AS `internal_message_id`,
        `path` AS `path`,
        `rcptto` AS `rcptto`,
        `subject` AS `subject`,
        `tls` AS `tls`,
        `to` AS `recipient`,
        `trans_depth` AS `trans_depth`,
        `ts` AS `_time`,
        `uid` AS `uid`,
        `user_agent` AS `user_agent`
FROM btv_dc30.silver.`zeek_smtp`;


-- Table: zeek_software | CIM Model: Inventory
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_software` AS
SELECT
        `host` AS `hostname`,
        `host_p` AS `host_p`,
        `name` AS `name`,
        `software_type` AS `software_type`,
        `ts` AS `timestamp`,
        `unparsed_version` AS `unparsed_version`,
        `version.addl` AS `version.addl`,
        `version.major` AS `version.major`,
        `version.minor` AS `version.minor`,
        `version.minor2` AS `version.minor2`,
        `version.minor3` AS `version.minor3`
FROM btv_dc30.silver.`zeek_software`;


-- Table: zeek_ssl | CIM Model: Certificates
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_ssl` AS
SELECT
        `cert_chain_fuids` AS `cert_chain_fuids`,
        `cipher` AS `cipher`,
        `client_cert_chain_fuids` AS `client_cert_chain_fuids`,
        `curve` AS `curve`,
        `established` AS `established`,
        `src_ip` AS `src`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest`,
        `dest_port` AS `dest_port`,
        `issuer` AS `ssl_issuer`,
        `ja3` AS `ja3`,
        `ja3s` AS `ja3s`,
        `last_alert` AS `last_alert`,
        `next_protocol` AS `next_protocol`,
        `resumed` AS `resumed`,
        `server_name` AS `server_name`,
        `subject` AS `ssl_subject`,
        `ts` AS `ts`,
        `uid` AS `uid`,
        `validation_status` AS `validation_status`,
        `version` AS `version`
FROM btv_dc30.silver.`zeek_ssl`;


-- Table: zeek_stats | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_stats` AS
SELECT
        `active_dns_requests` AS `active_dns_requests`,
        `active_files` AS `active_files`,
        `active_icmp_conns` AS `active_icmp_conns`,
        `active_tcp_conns` AS `active_tcp_conns`,
        `active_timers` AS `active_timers`,
        `active_udp_conns` AS `active_udp_conns`,
        `bytes_recv` AS `bytes_in`,
        `dns_requests` AS `dns_requests`,
        `events_proc` AS `events_proc`,
        `events_queued` AS `events_queued`,
        `files` AS `files`,
        `icmp_conns` AS `icmp_conns`,
        `mem` AS `mem`,
        `peer` AS `peer`,
        `pkt_lag` AS `pkt_lag`,
        `pkts_dropped` AS `pkts_dropped`,
        `pkts_link` AS `pkts_link`,
        `pkts_proc` AS `pkts_proc`,
        `reassem_file_size` AS `reassem_file_size`,
        `reassem_frag_size` AS `reassem_frag_size`,
        `reassem_tcp_size` AS `reassem_tcp_size`,
        `reassem_unknown_size` AS `reassem_unknown_size`,
        `tcp_conns` AS `tcp_conns`,
        `timers` AS `timers`,
        `ts` AS `_time`,
        `udp_conns` AS `udp_conns`
FROM btv_dc30.silver.`zeek_stats`;


-- Table: zeek_tunnel | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_tunnel` AS
SELECT
        `action` AS `action`,
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest_ip`,
        `dest_port` AS `dest_port`,
        `ts` AS `_time`,
        `tunnel_type` AS `tunnel_type`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_tunnel`;


-- Table: zeek_weird | CIM Model: Network Traffic
CREATE SCHEMA IF NOT EXISTS btv_dc30.gold;
CREATE TABLE IF NOT EXISTS btv_dc30.gold.`zeek_weird` AS
SELECT
        `addl` AS `addl`,
        `src_ip` AS `src_ip`,
        `src_port` AS `src_port`,
        `dest_ip` AS `dest_ip`,
        `dest_port` AS `dest_port`,
        `name` AS `name`,
        `notice` AS `notice`,
        `peer` AS `peer`,
        `source` AS `source`,
        `ts` AS `_time`,
        `uid` AS `uid`
FROM btv_dc30.silver.`zeek_weird`;
