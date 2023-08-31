just := "just --unstable"
image := "mishpocha-db"
config := "edgedb-config"
edgedb_instance := replace(image, "-", "_")
edgedb_command := "edgedb --instance " + edgedb_instance
connect_to_edgedb := just + " _create;" + edgedb_command
check_if_docker_running := "
if ! pgrep docker -q &>/dev/null; then
" + just + " _error_docker_not_running
    exit
fi
"
