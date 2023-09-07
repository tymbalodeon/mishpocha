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
        mkdir -p logs
        sub_folders=(api ui)
        for folder in "${sub_folders[@]}"; do
            (
                {{just}} "${folder}" start > logs/"${folder}".log 2>&1
            ) &
        done
        {{just}} db start
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

# Remove the log files and/or Docker images
[no-exit-message]
clean *args:
    #!/usr/bin/env zsh
    if [[ "{{args}}" = *"--logs"* ]] || [ -z "{{args}}" ]; then
        for file in logs/*(N); do
            rm "${file}"
        done
    fi
    if [[ "{{args}}" = *"--docker"* ]] || [ -z "{{args}}" ]; then
        sub_folders=(api db ui)
        for folder in "${sub_folders[@]}"; do
            {{just}} "${folder}" clean
        done
    fi

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
    instance="$({{just}} _get_instance "")"
    if [ "${instance}" = "docker" ]; then
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
    else
       for file in $(ls logs); do
            {{bat}} "logs/${file}"
       done
    fi

# Tail the logs for <log> ("api" or "ui").
tail *log:
    #!/usr/bin/env zsh
    if [[ "{{log}}" != *("api"|"ui")* ]]; then
        echo 'Please choose one of "api" or "ui".'
    elif [ -f "logs/{{log}}.log" ]; then
        tail -F logs/{{log}}.log
    else
        mkdir -p logs
        file="logs/{{log}}.log"
        touch "${file}"
        tail -F "${file}"
    fi

# Open the applications in the browser.
open *prod:
    #!/usr/bin/env zsh
    sub_folders=(api ui)
    for folder in "${sub_folders[@]}"; do
        {{just}} "${folder}" open {{prod}}
    done
