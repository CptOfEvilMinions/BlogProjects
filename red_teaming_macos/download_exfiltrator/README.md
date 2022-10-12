# File Actions exfil
This blog post is going to demonstrate a proof of concept (PoC) to exfiltrate data from macOS with a built-in functionality called Folder Actions. The Folder Actions functionality triggers Applescripts to execute code when certain conditions (creating files, deleting files, etc.) occur by interactions with Finder. This functionality provides a method to exfiltrate data without the need for a shell to execute the actions. The Applescript provided below will utilize this functionality to monitor for new files in the user's Download folder and, upon detection of a new file, exfiltrate a copy of the file to a remote server.

* [Exfiltrating data on macOS with Folder Actions](https://holdmybeersecurity.com/exfiltrating-data-on-macos-with-folder-actions)

## References
* [BaseHTTPServer — Basic HTTP server](https://docs.python.org/2/library/basehttpserver.html)
* [Core tools for working with streams](https://docs.python.org/3/library/io.html)
* [SimpleHTTPServerWithUpload.py](https://gist.github.com/touilleMan/eb02ea40b93e52604938)
