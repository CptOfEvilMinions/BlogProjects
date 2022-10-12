@load base/frameworks/files
@load base/frameworks/notice
@load base/protocols/smb

export
{
    redef enum Notice::Type += {  Match  };
    global isTrusted = T;
    global trustedIPs: set[addr] = {192.168.1.1,192.168.1.10} &redef;

    function hostAdminCheck(sourceip : addr) : bool
    {
            if (sourceip !in trustedIPs)
            {
                    return F;
            }
            else
            {
                    return T;
            }
    }

    event smb2_tree_connect_request(c : connection, hdr : SMB2::Header, path : string)
    {
            isTrusted = hostAdminCheck(c$id$orig_h);
            if (isTrusted == F) {
                    if ("IPC$" in path || "ADMIN$" in path || "C$" in path)
                    {
                            NOTICE([$note=Match, $msg=fmt("Potentially Malicious Use of an Administrative Share"), $sub=fmt("%s",path), $conn=c]);
                    }
            }
    }

    event smb1_tree_connect_andx_request(c : connection, hdr : SMB1::Header, path : string, service : string)
    {
            isTrusted = hostAdminCheck(c$id$orig_h);
            if (isTrusted ==F) {
                    if ("IPC$" in path || "ADMIN$" in path || "C$" in path)
                    {
                            NOTICE([$note=Match, $msg=fmt("Potentially Malicious Use of an Administrative Share"), $sub=fmt ("%s",path), $conn=c]);
                    }
            }
    }

}
