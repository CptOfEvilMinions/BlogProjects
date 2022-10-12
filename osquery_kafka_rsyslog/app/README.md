# Osquery file hash alerter

## Dev
1. `cd app`
1. `virtualenv -p python3 venv`

## Container build
1. `cp config/config.py.example config/config.py`
1. `vim config/config.py` and set:
    1.
    1.
1. `docker build -t python-app .`

## Supported Python versions
* Python 3.7

## References
* [Kafka-Python explained in 10 lines of code](https://towardsdatascience.com/kafka-python-explained-in-10-lines-of-code-800e3e07dad1)
* [Configuration files in Python](https://martin-thoma.com/configuration-files-in-python/)
* [VirusTotal Public API v2.0](https://www.virustotal.com/en/documentation/public-api/)
