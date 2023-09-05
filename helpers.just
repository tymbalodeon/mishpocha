bat := "bat --style plain --language json"
check_if_docker_running := "
if ! pgrep docker -q &>/dev/null; then
" + error_docker_not_running + "
    exit
fi
"
error_docker_not_running := "\
echo 'Docker not running. Please start Docker and try again.'"
get_instance := '\
if [ -n "$(pgrep docker -q)" ] && [ -z "{{instance}}" ] \
    || [[ "{{instance}}" = *"--docker"* ]]; then
    echo "docker"
else
    echo "local"
fi'
just := "just --unstable"
