!include helpers.just

@_help *all:
    {{just}} --list \
        {{ if all == "" { "" } else { "--list-heading $'ALL:\n'"  } }}

[no-exit-message]
@_run_justfile parent *args:
    {{just}} --justfile ./{{parent}}/Justfile {{args}}

# Run a just command for the API.
[no-exit-message]
@api *args:
    {{just}} _run_justfile api {{args}}

# Run a just command for the UI.
[no-exit-message]
@ui *args:
    {{just}} _run_justfile ui {{args}}

# Run a just command for the Database.
[no-exit-message]
@db *args:
    {{just}} _run_justfile db {{args}}

# Display help for all commands.
help:
    #!/usr/bin/env zsh
    {{just}} _help --all
    sub_folders=(api db ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" _help --from-main
    done

# Install dependencies.
install:
    #!/usr/bin/env zsh
    ./install_dependencies.sh --all
    sub_folders=(api db ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" install --from-main
    done

# Update dependencies.
update:
    #!/usr/bin/env zsh
    ./install_dependencies.sh --all --update
    sub_folders=(api db ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" update --from-main
    done

# Check for code errors.
check:
    #!/usr/bin/env zsh
    sub_folders=(api ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" check
    done

# Format code.
format:
    #!/usr/bin/env zsh
    sub_folders=(api ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" format
    done

_get_instance *instance:
    #!/usr/bin/env zsh
    {{get_instance}}

# Run the application (optional: "--docker", "--local", "--prod", "--open").
start *args: stop
    #!/usr/bin/env zsh
    if [[ "{{args}}" = *"--docker"* ]]; then
        instance="--docker"
    elif [[ "{{args}}" = *"--local"* ]]; then
        instance="local"
    else
        instance=""
    fi
    instance="$({{just}} _get_instance ${instance})"
    if [[ "{{args}}" = *"--open"* ]]; then
        {{just}} open {{ if args =~ "--prod" { "--prod" } else { "" } }}
    fi
    if [ "${instance}" = "docker" ]; then
        if [[ "{{args}}" = *"--prod"* ]]; then
            docker compose up --build --detach
        else
            docker compose \
                --file compose.yaml \
                --file compose-dev.yaml \
                up \
                    --build \
                    --detach
        fi
    else
        sub_folders=(api db ui)
        for folder in "${sub_folders[@]}"; do
            {{just}} "${folder}" start >/dev/null 2>&1 &
        done
    fi

# Stop the containers.
stop:
    #!/usr/bin/env zsh
    sub_folders=(api db ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" stop
    done
    if [ -n "$({{just}} running)" ]; then
        docker compose down
    fi

# Remove the Docker image.
[no-exit-message]
clean:
    #!/usr/bin/env zsh
    sub_folders=(api db ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" clean
    done

# Show the container ids (or all info with "--verbose") if the containers are running.
running *verbose:
    #!/usr/bin/env zsh
    if pgrep -q docker; then
        docker container ls \
            {{ if verbose =~ "--verbose" { "" } else { "--quiet" } }}
    fi

# Show the Docker logs up to <lines> lines.
logs lines="10":
    #!/usr/bin/env zsh
    if [ -n "$({{just}} api running)" ]; then
        echo "API logs:"
        {{just}} api logs {{lines}}
    fi
    if [ -n "$({{just}} db running)" ]; then
        echo
        echo "DB logs:"
        {{just}} db logs {{lines}}
    fi
    if [ -n "$({{just}} ui running)" ]; then
        echo
        echo "UI logs:"
        {{just}} ui logs {{lines}}
    fi

# Open the applications in the browser.
open *prod:
    #!/usr/bin/env zsh
    sub_folders=(api ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" open {{prod}}
    done
