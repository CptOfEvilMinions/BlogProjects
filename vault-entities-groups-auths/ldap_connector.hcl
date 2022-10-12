# Credit to https://www.burgundywall.com/post/hashicorp-vault-and-freeipa
path "auth/ldap/config" {
  url="ldap[s]://<LDAP FQDN>"
  userdn="cn=users,cn=accounts,dc=example,dc=com"
  userattr="uid"
  groupdn="cn=groups,cn=accounts,dc=example,dc=com"
  groupattr="cn"
  binddn="uid=<bind username>,cn=sysaccounts,cn=etc,dc=example,dc=com"
  bindpass="<BIND PASSWORD>"
  starttls=<false/true>
}
