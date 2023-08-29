#!/usr/bin/env zsh

main_directory="${"$(pwd)"/(ui|api)/}"
ui_directory="${main_directory}/ui"

dependencies=(
    "brew"
    "docker"
    "just"
)

IFS=" " read -r -A args <<< "$@"

if ((${args[(I)*--all*]})) \
    || ((${args[(I)*--api*]})) \
    || ((${args[(I)*--ui*]})); then
    dependencies+="rtx"
fi

if ((${args[(I)*--all*]})) \
    || ((${args[(I)*--db*]})); then
    dependencies+=(
        "edgedb"
    )
fi

if ((${args[(I)*--all*]})) \
    || ((${args[(I)*--ui*]})); then
    dependencies+=(
        "node"
        "pnpm"
    )
fi

install_dependency() {
    case ${1} in
        "brew")
            curl -fsSL \
                "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh"
            ;;
        "docker")
            brew install --cask docker
            ;;
        "edgedb")
            curl --proto '=https' --tlsv1.2 -sSf https://sh.edgedb.com | sh
            ;;
        "just")
            brew install just
            ;;
        "node")
            cd "${ui_directory}"
            rtx install
            ;;
        "pnpm")
            cd "${ui_directory}"
            npm install --global pnpm
            ;;
        "rtx")
            brew install rtx
            ;;
    esac
}

update_dependency() {
    case ${1} in
        "brew")
            brew update
            ;;
        "docker")
            brew_installed="$(brew info --cask docker | grep "Not installed")"
            if [ -z "brew_installed" ]; then
                brew upgrade --cask docker
            else
                echo "Docker was not installed with homebrew." \
                     "Please upgrade via the Docker application."
            fi
            ;;
        "edgedb")
            edgedb cli upgrade
            ;;
        "just")
            brew upgrade just
            ;;
        "pnpm")
            cd "${ui_directory}"
            pnpm add --global pnpm
            ;;
        "rtx")
            brew upgrade rtx
            ;;
    esac
}

for dependency in "${dependencies[@]}"; do
    case "${dependency}" in
        "node")
            cd "${ui_directory}"
            node_version="$(grep "node" .tool-versions)"
            node_version="${node_version//node /}"
            if printf "${node_version}" \
                | xargs -I % zsh -c \
                    'rtx list node \
                    | grep % \
                    | grep --quiet --invert-match missing'; then
                should_install=""
            else
                should_install="true"
            fi
            ;;
        *)
            if command -v "${dependency}" &>/dev/null; then
                should_install=""
            else
                should_install="true"
            fi
            ;;
    esac

    if [ -n "${should_install}" ]; then
        echo "Installing ${dependency}..."
        install_dependency "${dependency}"
    else
        echo "${dependency}" installed.
    fi
done

if ! ((${args[(I)*--update*]})); then
    exit
fi

for dependency in "${dependencies[@]}"; do
    update_dependency "${dependency}"
done
