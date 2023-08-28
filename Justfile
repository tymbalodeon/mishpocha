@_help *all:
    just --list \
        {{ if all == "" { "" } else { "--list-heading $'ALL:\n'"  } }}

# Display help for all commands.
help:
    #!/usr/bin/env zsh
    just _help --all
    just api _help --from-main
    just db _help --from-main
    just ui _help --from-main

@_run_justfile parent *args:
    just --justfile ./{{parent}}/Justfile {{args}}

# Run a just command for the API.
@api *args:
    just _run_justfile api {{args}}

# Run a just command for the UI.
@ui *args:
    just _run_justfile ui {{args}}

# Run a just command for the Database.
@db *args:
    just _run_justfile db {{args}}

# Install dependencies.
@install:
    ./install_dependencies.sh --all
    just api install --from-main
    just ui install --from-main

# Update dependencies.
@update:
    ./install_dependencies.sh --all --update
    just api update --from-main
    just ui update --from-main

# Open the applications in the browser.
@open *prod:
    just api open
    just ui open {{prod}}

# Run the containers, optionally in "--prod" mode, and optionally "--open" in the browser.
start *args: stop
    #!/usr/bin/env zsh
    if [[ "{{args}}" = *--prod* ]]; then
        docker compose up --build --detach
        {{ if args =~ "--open" { "just open --prod" } else { "" } }}
    else
        docker compose \
            --file compose.yaml \
            --file compose-dev.yaml \
            up \
                --build \
                --detach
        {{ if args =~ "--open" { "just open" } else { "" } }}
    fi

# Stop the containers.
@stop:
    just api stop
    just db stop
    just ui stop
    docker compose down

# Remove the Docker image.
@clean:
    # just api clean
    just db clean
    just ui clean

# List running containers.
running:
    #!/usr/bin/env zsh
    if pgrep -q docker; then
        docker container ls
    fi

# Show the Docker logs.
logs tail="10":
    #!/usr/bin/env zsh
    if [ -n "$(just api _is_running)" ]; then
        echo "API logs:"
        just api logs {{tail}}
    fi
    if [ -n "$(just db _is_running)" ]; then
        echo
        echo "DB logs:"
        just db logs {{tail}}
    fi
    if [ -n "$(just ui _is_running)" ]; then
        echo
        echo "UI logs:"
        just ui logs {{tail}}
    fi
