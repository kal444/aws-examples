playbook="$1"
shift
ansible-playbook "${playbook}" -i hosts $*
