bat := "bat --style plain --language json --theme gruvbox-dark"
check_if_docker_running := "
if ! pgrep docker -q &>/dev/null; then
" + error_docker_not_running + "
    exit
fi
"
error_docker_not_running := "\
echo 'Docker not running. Please start Docker and try again.'"
just := "just --unstable"
