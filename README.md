 # Mishpocha

 A database schema for recording information about music and musicians. Gather
 the "whole [mishpocha ](https://www.merriam-webster.com/dictionary/mishpachah)" in one graph-relational database!

 ## Dependencies

 Required:

 - [edgedb](https://www.edgedb.com/)
 - [rustup](https://rustup.rs/)
 - [node](https://nodejs.org/en)

 Recommended:

 - [Docker](https://www.docker.com/ "Docker")
 - [Homebrew](https://brew.sh/ "Homebrew")
 - [Just](https://just.systems/man/en/ "Just")
 - [pnpm](https://pnpm.io/ "pnpm")
 - [rtx-cli](https://lib.rs/crates/rtx-cli "rtx")

 ## Usage

 ### Quick Start

 1. Install the dependencies. If [just](https://just.systems/man/en/) is already installed, run `just install`,
    otherwise run:
    ```sh
    ./install_dependencies.sh --all
    ```
 2. If using Docker, start the Docker daemon if it isn't running already.
 3. Run `just start --open`.

 ### Just

 Just is used to run the commands in the Justfiles. Run `just` to see a list of
 available commands relevant to the current directory you are in, or `just help`
 to see a list of all available commands, which are also listed here:

 ALL:
 `api *args` # Run a just command for the API.  
 `check` # Check for code errors.  
 `clean` # Remove the Docker image.  
 `db *args` # Run a just command for the Database.  
 `format` # Format code.  
 `help` Display help for all commands.  
 `install` Install dependencies.  
 `logs lines="10"` Show the Docker logs up to <lines> lines.  
 `open *prod` Open the applications in the browser.  
 `running *verbose` Show the container ids (or all info with "--verbose") if the
 containers are running.  
 `start *args` Run the application (optional: "--docker", "--local", "--prod", "--open").  
 `stop`Stop the containers.  
 `ui *args` Run a just command for the UI.  
 `update` Update dependencies.

 API: [`just --unstable api <COMMAND>`]
 `add *packages` Add dependencies.
 `check` Check code for errors.
 `clean` Remove the Docker image.
 `format` Format code.
 `install *_from-main` Install dependencies.
 `list` List dependencies.
 `logs lines="20"` Show the Docker logs up to <lines> lines.
 `open` Open the application in the browser.
 `people` View people in the database.
 `person full_name` View a person in the database.
 `ping` Ping the application.
 `remove *packages` Remove dependencies.
 `running *verbose` Show the container id (or all info with "--verbose") if the container is running.
 `shell` Log into the interactive shell in Docker.
 `start *args` Run the application (optional: "--docker", "--local", "--prod", "--open").
 `stop` Stop the server.
 `update *_from-main` Update dependencies.

 DB: [`just --unstable db <COMMAND>`]
 `clean` Remove the Docker image.
 `destroy *instance` Destroy the persisted databases (optional: "--docker", or "--local").
 `dsn *instance` Show the DSN for the database (optional: "--docker" or "--local").
 `install *_from-main` Install dependencies.
 `logs lines="20"` Show the Docker logs up to <lines> lines.
 `migrate` Migrate the (local) database.
 `query *query` Show available queries, or <query> the database.
 `running *verbose` Show the container id (or all info with "--verbose") if the container is running.
 `seed *instance` Seed the database (optional: "--docker" or "--local").
 `shell *instance` Open the edgedb shell (optional: "--docker" or "--local").
 `start *args` Run the Docker container, and optionally "--open" in the browser.
 `stop` Stop the Docker container.
 `ui *instance` Open the Edgedb UI (optional: "--docker" or "--local")
 `update *_from-main` Update dependencies.

 UI: [`just --unstable ui <COMMAND>`]
 `add *packages` Add dependencies.
 `add-dev *packages` Add dependencies to "dev" group.
 `check` Check code for errors.
 `clean` Remove the Docker image.
 `format` Format code.
 `install *_from-main` Install dependencies.
 `list` List dependencies.
 `logs tail="20"` Show the Docker logs up to <lines> lines.
 `open *prod` Open the application in the browser.
 `remove *packages` Remove dependencies.
 `remove-dev *packages` Remove dependencies from "dev" group.
 `running *verbose` Show the container id (or all info with "--verbose") if the container is running.
 `shell` Log into the interactive shell in Docker.
 `start *args` Run the application (optional: "--docker", "--local", "--prod", "--open").
 `stop` Stop the server.
 `update *_from-main` Update dependencies.
