# flake8: noqa
# pylint: skip-file
#!/usr/bin/env python3

"""Simple HTTP Server With Upload.

This module builds on BaseHTTPServer by implementing the standard GET
and HEAD requests in a fairly straightforward manner.

see: https://gist.github.com/UniIsland/3346170
"""


__version__ = "0.1"
__all__ = ["SimpleHTTPRequestHandler"]
__author__ = "bones7456"
__home_page__ = "http://li2z.cn/"

import http.server
import os
from io import BytesIO


class SimpleHTTPRequestHandler(http.server.BaseHTTPRequestHandler):

    """Simple HTTP request handler with GET/HEAD/POST commands.

    This serves files from the current directory and any of its
    subdirectories.  The MIME type for files is determined by
    calling the .guess_type() method. And can reveive file uploaded
    by client.

    The GET/HEAD/POST requests are identical except that the HEAD
    request omits the actual contents of the file.

    """

    server_version = "SimpleHTTPWithUpload/" + __version__

    def do_POST(self):
        """Save a file following a HTTP PUT request"""
        filename = os.path.basename(self.path)
        # Don't overwrite files
        if os.path.exists(filename):
            self.send_response(409, "Conflict")
            self.end_headers()
            reply_body = '"%s" already exists\n' % filename
            self.wfile.write(reply_body.encode("utf-8"))
            return

        file_length = int(self.headers["Content-Length"])
        with open(filename, "wb") as output_file:
            output_file.write(self.rfile.read(file_length))
        self.send_response(201, "Created")
        self.end_headers()
        reply_body = 'Saved "%s"\n' % filename
        self.wfile.write(reply_body.encode("utf-8"))


def test(HandlerClass=SimpleHTTPRequestHandler, ServerClass=http.server.HTTPServer):
    http.server.test(HandlerClass, ServerClass)


if __name__ == "__main__":
    test()
