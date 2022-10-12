# flake8: noqa
# pylint: skip-file
import argparse
import os
import sys
from datetime import datetime
from os.path import expanduser

import requests
import urllib3
import yaml
from colorama import Back, Fore, Style
from jinja2 import Template

urllib3.disable_warnings()


def create_http_session(general_config):
    session = requests.Session()

    # Generate session
    if (
        general_config["client_cert_file_path"] != ""
        and general_config["ca_cert_file_path"] != ""
        and general_config["client_key_file_path"] != ""
    ):
        session.cert = (
            general_config["client_cert_file_path"],
            general_config["client_key_file_path"],
        )
        session.verify = general_config["ca_cert_file_path"]
    else:
        session.verify = False
    return session


def check_vault_token(session, vault_addr):
    """
    Check if Vault token is valid
    """
    vault_token = str()
    with open(expanduser("~/.vault-token"), "r") as f:
        vault_token = f.read().strip()

        headers = {"X-Vault-Token": vault_token}
        r = session.get(url=f"{vault_addr}/v1/auth/token/lookup-self", headers=headers)
        if r.json().get("errors"):
            print(
                Fore.RED
                + f"[-] - {datetime.now()} - Vault token invlaid"
                + Style.RESET_ALL
            )
            sys.exit(1)
    return vault_token


def check_vault_mount_exists(vault_addr, vault_path):
    """
    Checks if a Vault mount path exists
    """
    headers = {"X-Vault-Token": vault_token}
    url = f"{vault_addr}/v1/sys/mounts"
    r = requests.get(url=url, headers=headers, verify=False)

    if (
        vault_path[:-1] != "/" and vault_path + "/" in r.json().keys()
    ) or vault_path in r.json().keys():
        return True
    return False


def check_vault_role_exists(vault_addr, vault_path, vault_role):
    """
    Checks if a Vault role exists
    """
    headers = {"X-Vault-Token": vault_token}
    url = f"{vault_addr}/v1/{vault_path}/roles"
    r = requests.request("LIST", url=url, headers=headers, verify=False)
    if r.status_code == 404:
        return False
    return True


def check_vault_cert_exists(vault_addr, vault_path, session):
    """
    Checks if a Vault certificate exists
    """
    result = session.request(
        "LIST",
        url=f"{vault_addr}/v1/{vault_path}/certs",
    )
    if result.status_code == 404:
        return False
    return True


def read_config(args):
    ### YAML config ###
    yaml_config = None
    with open(args.config, "r") as ymlfile:
        yml_content = ymlfile.read().rstrip()
        template = Template(yml_content)
        yaml_template = template.render(
            vault_addr=args.vault_addr,
            logging_domain=args.logging_domain,
            server_leaf_cert_hostname=args.server_leaf_cert_hostname,
            client_leaf_cert_hostname=args.client_leaf_cert_hostname,
        )
        yaml_config = yaml.load(yaml_template, Loader=yaml.Loader)
    return yaml_config


def generate_vault_pki_int(vault_addr, pki_int, session):
    """
    Input: Vault addr, Vault token, and PKI intermediate settings
    Output: Write the intermediate certificate to disk
    """
    ################################################ Create mount ################################################
    if check_vault_mount_exists(vault_addr, pki_int["vault_mount_path"]) == False:
        #### Create Vault PKI path and set max ttl ####
        session.post(
            url=f"{ vault_addr }/v1/sys/mounts/{ pki_int['vault_mount_path'] }",
            data={"type": "pki"},
        )
        session.post(
            url=f"{ vault_addr }/v1/sys/mounts/{ pki_int['vault_mount_path'] }/tune",
            data={"max_lease_ttl": pki_int["ttl"]},
        )
        print(
            Fore.GREEN
            + f"[+] - {datetime.now()} - Created PKI path: {pki_int['vault_mount_path']}"
            + Style.RESET_ALL
        )
    else:
        print(
            Fore.YELLOW
            + f"[*] - {datetime.now()} - SKIPPING creating mount for: {pki_int['vault_mount_path']}"
            + Style.RESET_ALL
        )

    ################################################ Create certificate ################################################
    if (
        check_vault_cert_exists(vault_addr, pki_int["vault_mount_path"], session)
        == False
    ):
        #### Generate intermedaite CSR ####
        result = session.post(
            url=f"{vault_addr}/v1/{pki_int['vault_mount_path']}/intermediate/generate/internal",
            data={"common_name": pki_int["common_name"]},
        ).json()

        csr_data = str()
        with open(
            f"{pki_int['output_dir_path']}/{pki_int['vault_mount_path']}.csr", "w"
        ) as f:
            csr_data = result["data"]["csr"]
            f.write(str(csr_data))
        os.remove(f"{pki_int['output_dir_path']}/{pki_int['vault_mount_path']}.csr")
        print(
            Fore.GREEN
            + f"[+] - {datetime.now()} - Generated certificate signing request for: {pki_int['common_name']}"
            + Style.RESET_ALL
        )

        #### Generate and sign intermedaite cert ####
        result = session.post(
            url=f"{vault_addr}/v1/{pki_int['vault_sign_path']}/root/sign-intermediate",
            data={"csr": csr_data, "format": "pem_bundle", "ttl": pki_int["ttl"]},
        ).json()

        cert_data = str()
        with open(
            f"{pki_int['output_dir_path']}/{pki_int['vault_mount_path']}.crt", "w"
        ) as f:
            cert_data = result["data"]["certificate"]
            f.write(cert_data)
        print(
            Fore.GREEN
            + f"[+] - {datetime.now()} - Generated certificate for: {pki_int['common_name']}"
            + Style.RESET_ALL
        )

        #### Write certificate to Vault ####
        session.post(
            url=f"{vault_addr}/v1/{pki_int['vault_mount_path']}/intermediate/set-signed",
            data={"certificate": cert_data},
        )
        print(
            Fore.GREEN
            + f"[+] - {datetime.now()} - Write certificate to Vault for: {pki_int['common_name']}"
            + Style.RESET_ALL
        )
    else:
        print(
            Fore.YELLOW
            + f"[*] - {datetime.now()} - SKIPPING creating certificate for: {pki_int['common_name']}"
            + Style.RESET_ALL
        )

    ################################################ Create role ################################################
    if (
        check_vault_role_exists(
            vault_addr, pki_int["vault_mount_path"], pki_int["vault_role"]
        )
        == False
    ):
        #### Create role ####
        session.post(
            url=f"{vault_addr}/v1/{pki_int['vault_mount_path']}/roles/{pki_int['vault_role']}",
            data={
                "allowed_domains": pki_int["allowed_domains"],
                "allow_subdomains": pki_int["allow_subdomains"],
                "max_ttl": pki_int["ttl"],
            },
        )
        print(
            Fore.GREEN
            + f"[+] - {datetime.now()} - Create role for: {pki_int['common_name']}"
            + Style.RESET_ALL
        )
    else:
        print(
            Fore.YELLOW
            + f"[*] - {datetime.now()} - SKIPPING creating role for: {pki_int['common_name']}"
            + Style.RESET_ALL
        )


def generate_vault_leaf_cert(
    vault_addr, cert_leaf, logging_domain, leaf_cert_hostname, session
):
    """
    Input: Vault addr, Vault token, Leaf cert settings, logging domain for cert, and hostname
    Output: Write the leaf private key and leaf public cert to disk
    """
    #### Generate leaf JSON blob ####
    result = session.post(
        url=f"{vault_addr}/v1/{cert_leaf['vault_mount_path']}/issue/{cert_leaf['vault_role']}",
        data={
            "common_name": cert_leaf["common_name"],
            "ttl": cert_leaf["ttl"],
            "private_key_format": cert_leaf["private_key_format"],
        },
    ).json()
    print(
        Fore.GREEN
        + f"[+] - {datetime.now()} - Generated private key and public certificate for: { cert_leaf['common_name'] }"
        + Style.RESET_ALL
    )

    #### Extract private key ####
    with open(
        f"{cert_leaf['output_dir_path']}/{  cert_leaf['common_name'].replace('.','-') }.key",
        "w",
    ) as f:
        f.write(result["data"]["private_key"])

    #### Extract public cert and chain chain ####
    with open(
        f"{cert_leaf['output_dir_path']}/{ cert_leaf['common_name'].replace('.','-') }.crt",
        "w",
    ) as f:
        f.write(result["data"]["certificate"] + "\n")
        for ca_cert in result["data"]["ca_chain"]:
            f.write(ca_cert + "\n")


if __name__ == "__main__":
    my_parser = argparse.ArgumentParser()

    my_parser.add_argument(
        "--vault_addr",
        type=str,
        required=True,
        help="Example: https://vault.example:443",
    )
    my_parser.add_argument(
        "--logging_domain", type=str, required=True, help="Example: example.com"
    )
    my_parser.add_argument(
        "--config",
        type=str,
        default="conf/vault/vault_setup.yaml",
        help="Example: conf/vault/vault_setup.yaml",
    )

    group = my_parser.add_mutually_exclusive_group()
    group.add_argument("--setup_logging_pki", action="store_true")
    group.add_argument("--create_leaf_cert", action="store_false")

    leaf_cert_group = my_parser.add_mutually_exclusive_group()
    leaf_cert_group.add_argument(
        "--server_leaf_cert_hostname", type=str, help="Example: logstash01"
    )
    leaf_cert_group.add_argument(
        "--client_leaf_cert_hostname", type=str, help="Example: filebeat01"
    )

    args = my_parser.parse_args()

    # Read config
    yaml_config = read_config(args)

    # Check that Vault token exists
    session = create_http_session(yaml_config["general"])
    vault_token = check_vault_token(session, args.vault_addr)

    # Set header with Vault token
    session.headers.update({"X-Vault-Token": vault_token})

    if args.setup_logging_pki:
        generate_vault_pki_int(
            args.vault_addr, yaml_config["pki_int_dict"]["loging_int"], session
        )  # Create logging PKI int
        generate_vault_pki_int(
            args.vault_addr, yaml_config["pki_int_dict"]["server_logging_int"], session
        )  # Create server logging PKI int
        generate_vault_pki_int(
            args.vault_addr, yaml_config["pki_int_dict"]["client_logging_int"], session
        )  # Create client logging PKI int
    elif (
        args.create_leaf_cert is not None and args.server_leaf_cert_hostname is not None
    ):
        # Create Logstash leaf cert
        generate_vault_leaf_cert(
            args.vault_addr,
            yaml_config["cert_leaf_dict"]["servers"],
            args.logging_domain,
            args.server_leaf_cert_hostname,
            session,
        )
    elif (
        args.create_leaf_cert is not None and args.client_leaf_cert_hostname is not None
    ):
        # Create Logstash leaf cert
        generate_vault_leaf_cert(
            args.vault_addr,
            yaml_config["cert_leaf_dict"]["clients"],
            args.logging_domain,
            args.client_leaf_cert_hostname,
            session,
        )
    else:
        print("Non-valid flag combo")
