 # Mishpocha

 ## Dependencies

 Required:

 - [Docker](https://www.docker.com/ "Docker")
 - [pnpm](https://pnpm.io/ "pnpm")

 Recommended:

 - [Homebrew](https://brew.sh/ "Homebrew")
 - [rtx-cli](https://lib.rs/crates/rtx-cli "rtx")
 - [Just](https://just.systems/man/en/ "Just")

 ## Usage

 ### Quick Start

 1. Install the dependencies. If just is already installed, run `just install`,
    otherwise run:
    ```sh
    ./install_dependencies.sh --all \
    && just api install --from-main \
    && just ui install --from-main
    ```
 2. Start the Docker daemon if it isn't running already.
 3. Run `just start --open` to build and run the containers and open the
    browser.

 ### Just

 Just is used to run the commands in the Justfiles. Run `just` to see a list of
 available commands relevant to the current directory you are in, or `just help`
 to see a list of all available commands, which are also listed here:

 ALL:

 - `api *args`: Run a just command for the API.
 - `db *args`: Run a just command for the Database.
 - `help`: Display help for all commands.
 - `install`: Install dependencies.
 - `logs`: Show the Docker logs.
 - `open`: Open the applications in the browser.
 - `running`: List running containers.
 - `start *args`: Run the containers, optionally in "--prod" mode, and
   optionally "--open" in the browser.
 - `stop`: Stop the containers.
 - `ui *args`: Run a just command for the UI.
 - `update`: Update dependencies.

 API: [`just api <COMMAND>`]

 - `add *packages`: Add dependencies.
 - `add-dev *packages`: Add dependencies to "dev" group.
 - `install *_from-main`: Install dependencies.
 - `list`: List dependencies.
 - `local *open`: Run the app locally, optionally "--with-database" and
   optionally "--open" in the browser.
 - `logs`: Show the Docker logs.
 - `open`: Open the application in the browser.
 - `remove *packages`: Remove dependencies.
 - `remove-dev *packages`: Remove dependencies from "dev" group.
 - `running`: Show if the container is running.
 - `shell`: Log into the interactive shell in Docker.
 - `start *args`: Run the Docker container, and optionally "--open" in the
   browser.
 - `stop`: Stop the Docker container.
 - `update *_from-main`: Upgrade dependencies.
 - `venv`: Create a new virtual environment, overwriting an existing one if
   present.

 DB: [`just db <COMMAND>`]

 - `install *_from-main`: Install dependencies.
 - `local *ui`: Connect to the database locally, optionally via the edgedb
   "--ui".
 - `logs tail="20"`: Show the Docker logs.
 - `migrate`: Migrate the database.
 - `running`: Show if the container is running.
 - `shell`: Log into the interactive shell in Docker.
 - `start`: Run the Docker container.
 - `stop`: Stop the Docker container.

 UI: [`just ui <COMMAND>`]

 - `add *packages`: Add dependencies.
 - `add-dev *packages`: Add dependencies to "dev" group.
 - `format`: Format code.
 - `install *_from-main`: Install dependencies.
 - `list`: List dependencies.
 - `local *open`: Run project locally, and optionally "--open" in browser.
 - `logs`: Show the Docker logs.
 - `open`: Open the application in the browser.
 - `remove *packages`: Remove dependencies.
 - `remove-dev *packages`: Remove dependencies from "dev" group.
 - `running`: Show if the container is running.
 - `shell`: Log into the interactive shell in Docker.
 - `start *args`: Run the Docker container, optionally in "--prod" mode, and
   optionally "--open" in the browser.
 - `stop`: Stop the Docker container.
 - `update *_from-main`: Update dependencies.
