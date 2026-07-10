rule ssh_private_key
{
    meta:
        author      = "CptOfEvilMinions"
        description = "Detects OpenSSH private key material resident in process memory"
        reference   = "https://holdmybeersecurity.com"
        date        = "2026-07-08"
        scope       = "tuned for yara_process memory scanning (osquery/Fleet)"

    strings:
        // Canonical PEM armor (5 dashes each side)
        $pem_header   = "-----BEGIN OPENSSH PRIVATE KEY-----" ascii
        $pem_footer   = "-----END OPENSSH PRIVATE KEY-----"   ascii

        // UTF-16LE variant, in case the key sits in a wide-char buffer
        $pem_header_w = "-----BEGIN OPENSSH PRIVATE KEY-----" wide

        // Base64 of the decoded key's magic "openssh-key-v1\x00".
        // Catches keys whose armor is stripped/split but whose body is intact.
        $magic_b64    = "b3BlbnNzaC1rZXktdjEA" ascii

    condition:
        any of them
}
