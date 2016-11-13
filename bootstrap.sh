# this is needed for all 16.04 ubuntu machines since they don't have python 2 by default
ansible -m raw -a "apt-get update && apt-get -y --no-install-recommends install python2.7 python-simplejson aptitude" --become $*
