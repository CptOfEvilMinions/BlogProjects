!/bin/bash

declare sysmon_event_names
sysmon_event_names=(
  ["1"]="ProcessCreation"
  ["2"]="ProcessChangedAFileCreationTime"
  ["3"]="NetworkConnection"
  ["4"]="SysmonServiceStateChanged"
  ["5"]="ProcessTerminated"
  ["6"]="DriverLoaded"
  ["7"]="ImageLoaded"
  ["8"]="CreateRemoteThread"
  ["9"]="RawAccessRead"
  ["10"]="ProcessAccess"
  ["11"]="FileCreate"
  ["12"]="RegistryEventObjectCreateAndDelete"
  ["13"]="RegistryEventValueSet"
  ["14"]="RegistryEventKeyAndValueRename"
  ["15"]="FileCreateStreamHash"
  ["16"]="ServiceConfigurationChange"
  ["17"]="PipeEventPipeCreated"
  ["18"]="PipeEventPipeConnected"
  ["19"]="WmiEventFilterActivityDetected"
  ["20"]="WmiEventConsumerActivityDetected"
  ["21"]="WmiEventConsumerToFilterActivityDetected"
  ["22"]="DnsEventDnsQuery"
  ["23"]="FileDeleteArchived"
  ["24"]="ClipboardChange"
  ["25"]="ProcessTampering"
  ["26"]="FileDeleteDetected"
  ["27"]="FileBlockExecutable"
  ["28"]="FileBlockShredding"
  ["29"]="FileExecutableDetected"
  ["255"]="Error"
)


curl -L https://github.com/1ead30b0-fd55-4f2b-9c74-7ca8857d6ac0 --output /tmp/btv_dc30_zeek.zip
curl -L https://github.com/ef65f748-9f6d-44c6-a7f6-7af4f304040a --output /tmp/btv_dc30_filebeat.zip

mkdir /tmp/btv_dc30
unzip /tmp/btv_dc30_zeek.zip -d /tmp/btv_dc30
unzip /tmp/btv_dc30_filebeat.zip -d /tmp/btv_dc30

echo "---------------------------------------------------- sysmon ----------------------------------------------------"
mkdir -p logs/sysmon
for event_id in $(jq -r '.winlog.event_id' /tmp/btv_dc30/sysmon/sysmon-*.log | sort | uniq); do
  echo "Parsing ${sysmon_event_names[$event_id]}"
  mkdir -p logs/sysmon/${sysmon_event_names[$event_id]}
  jq -c ". | select(.winlog.event_id == \"${event_id}\")" /tmp/btv_dc30/sysmon/sysmon-*.log > logs/sysmon/${sysmon_event_names[$event_id]}/sysmon.log
done


echo "---------------------------------------------------- osquery ----------------------------------------------------"
mkdir -p logs/osquery
for name in $(jq -r '.json.name' /tmp/btv_dc30/filebeat/osquery-*.log | sort | uniq); do
  echo "Processing $name"
  mkdir -p logs/osquery/${name}
  jq -c ". | select(.json.name == \"${name}\")" /tmp/btv_dc30/filebeat/osquery-*.log > logs/osquery/${name}/osquery.log
done

echo "---------------------------------------------------- zeek ----------------------------------------------------"
mkdir -p logs/zeek
find /tmp/btv_dc30/zeek/ -type f | while IFS= read -r file; do
  zeek_type=$(basename "$file" | cut -d. -f1)
  echo $zeek_type

  mkdir -p logs/zeek/${zeek_type}/

  find /tmp/btv_dc30/zeek/ -type f -name "${zeek_type}.*.log" -exec cat {} + > logs/zeek/${zeek_type}/zeek.log
done | sort -u
rm -rd logs/zeek/conn-summary
rm -rd logs/zeek/capture_loss

echo "---------------------------------------------------- wineventlogs ----------------------------------------------------"
mkdir -p logs/wineventlogs
jq -r '.winlog.channel' /tmp/btv_dc30/filebeat/wineventlogs-*.log | sort | uniq | while IFS= read -r channel; do
  echo "Processing channel: $channel"
  channel_path=$(echo ${channel} | sed 's|/Operational$||' | sed -e 's/ /_/g')
  mkdir -p logs/wineventlogs/${channel_path}
  jq -c ". | select(.winlog.channel == \"${channel}\")" /tmp/btv_dc30/filebeat/wineventlogs-*.log > logs/wineventlogs/${channel_path}/wineventlogs.log
done



echo "---------------------------------------------------- hmail ----------------------------------------------------"
mkdir -p logs/hmail
find /tmp/btv_dc30/filebeat/ -type f -name "hmail-*.log" -exec cat {} + > logs/hmail/hmail.log
