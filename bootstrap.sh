host=$1
ansible -i hosts -m raw -a "apt-get update && apt-get -y --no-install-recommends install python2.7 python-simplejson aptitude" --become $host
