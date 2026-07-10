rule CopyFail_CVE_2026_31431_Exploitation {
    meta:
        description = "Detects Copy Fail (CVE-2026-31431) Linux kernel privilege escalation exploit"
        author = "Detection Engineering"
        date = "2026-06-24"
        cve = "CVE-2026-31431"
        severity = "critical"
        reference = "https://www.copy.fail/"

    strings:
        // AF_ALG crypto socket interface abuse
        $af_alg1 = "AF_ALG" wide
        $af_alg2 = "algif_aead" nocase
        $af_alg3 = "socket(2)" wide
        $af_alg4 = "sockaddr_alg" nocase

        // splice() system call exploitation
        $splice1 = "splice" wide
        $splice2 = "vmsplice" wide
        $splice3 = "SPLICE_F" wide
        $splice4 = "get_user_pages" wide

        // AEAD cipher operations (authencesn algorithm specifically)
        $aead1 = "authencesn" nocase
        $aead2 = "aead_request" nocase
        $aead3 = "AEAD" nocase
        $aead4 = "gcm" nocase

        // Page cache manipulation
        $pagecache1 = "page_pool" wide
        $pagecache2 = "__page_cache" wide
        $pagecache3 = "mark_page_accessed" wide
        $pagecache4 = "page->flags" wide

        // Target privileged binaries
        $target1 = "/usr/bin/su" wide
        $target2 = "/usr/bin/sudo" wide
        $target3 = "/usr/sbin/sshd" wide
        $target4 = "/bin/chmod" wide
        $target5 = "/bin/chown" wide

        // Privilege escalation indicators
        $priv1 = "setuid" wide
        $priv2 = "seteuid" wide
        $priv3 = "CAP_SETUID" wide
        $priv4 = "CAP_SYS_ADMIN" wide

        // Buffer/memory write patterns
        $write1 = "memcpy" wide
        $write2 = "memmove" wide
        $write3 = "copy_to_user" wide
        $write4 = "write" wide

        // In-place crypto operation (2017 kernel optimization)
        $inplace1 = "in_place" nocase
        $inplace2 = "src == dst" wide
        $inplace3 = "reuse" nocase

        // PoC patterns (Python/Go implementations)
        $poc1 = "python" nocase
        $poc2 = "ctypes" nocase
        $poc3 = "subprocess" nocase
        $poc4 = "golang" nocase

    condition:
        // AF_ALG + splice combo (core exploit mechanism)
        (2 of ($af_alg*)) and (1 of ($splice*)) or

        // AF_ALG + AEAD + Page cache (full chain)
        (1 of ($af_alg*)) and (1 of ($aead*)) and (1 of ($pagecache*)) or

        // Direct binary targeting with privilege escalation
        (1 of ($target*)) and (2 of ($priv*)) and (1 of ($write*)) or

        // Full exploitation pattern
        (1 of ($af_alg*)) and (1 of ($splice*)) and (1 of ($aead*)) and (1 of ($target*))
}

rule CopyFail_PoC_Code {
    meta:
        description = "Detects Copy Fail proof-of-concept code patterns"
        severity = "high"

    strings:
        // Python PoC patterns (10-line exploit mentioned)
        $py1 = "socket.socket" wide
        $py2 = "socket.AF_ALG" wide
        $py3 = "sendmsg" wide
        $py4 = "recvmsg" wide

        // Go exploit patterns
        $go1 = "golang.org/x/sys/unix" wide
        $go2 = "unix.Socket" wide
        $go3 = "unix.Bind" wide

        // Rust exploit patterns
        $rust1 = "libc::" wide
        $rust2 = "unsafe" wide
        $rust3 = "socket" wide

    condition:
        (2 of ($py*)) or (2 of ($go*)) or (2 of ($rust*))
}

rule CopyFail_Kernel_Exploitation {
    meta:
        description = "Detects kernel page cache corruption artifacts"
        severity = "critical"

    strings:
        // Kernel memory corruption signatures
        $corrupt1 = "page_offset" wide
        $corrupt2 = "page_flags" wide
        $corrupt3 = "buffer_head" wide
        $corrupt4 = "address_space" wide

        // Controlled write pattern (4-byte write)
        $write1 = { 00 00 00 04 } // 4-byte length
        $write2 = { FF FF FF FC } // -4 in signed

        // Crypto API internals
        $crypto1 = "crypto_aead" wide
        $crypto2 = "tfm" wide
        $crypto3 = "alg_name" wide

    condition:
        (2 of ($corrupt*)) and (1 of ($write*)) and (1 of ($crypto*))
}
