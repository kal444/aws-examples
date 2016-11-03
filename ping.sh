host=$1
ansible -i hosts -m ping $host
