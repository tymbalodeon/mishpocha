!include ../helpers.just
!include helpers.just

query_command := just + " --justfile queries.just _query"
bat := "bat --style plain --language json"

@_help:
    {{just}} --justfile queries.just --list

_query query *instance:
    #!/usr/bin/env zsh
    {{just}} seed
    instance="$({{just}} _get_instance {{instance}})"
    if [ "${instance}" = "docker" ]; then
        {{check_if_docker_running}}
        if [ -z "$({{just}} running)" ]; then
            {{just}} start
        fi
        docker run \
            --interactive \
            --link {{image}} \
            --rm \
            --tty \
            --volume {{config}}:/.config/edgedb \
            edgedb/edgedb-cli \
                --instance {{edgedb_instance}} \
                query "{{query}}" \
                | sed -e $'s/\x1b\[[0-9;]*m//g' \
                | {{bat}}
    else
        {{edgedb_command}} query "{{query}}" | {{bat}}
    fi

# Delete all objects in the database.
@delete *instance:
    {{query_command}} \
        "delete Album; \
        delete Disc; \
        delete Track; \
        delete Player; \
        delete Artist; \
        delete Person; \
        delete Composition; \
        delete Label; \
        delete Date; \
        delete Instrument;" \
        {{instance}}

select_date := "\
select Date { \
    local_date, \
    birthdays := .births.full_name \
}"

# Select dates in the database.
@dates *instance:
    {{query_command}} "{{select_date}}" {{instance}}

# Select a date in the database.
@date display *instance:
    {{query_command}} \
        "{{select_date}} filter <str>.local_date ilike '%{{display}}%'" \
        {{instance}}

select_person := "\
select Person { \
    full_name, \
    birthday := .birth_date.local_date, \
    age, \
    is_alive, \
    person_instruments := .instruments.name, \
    person_groups := .groups.name, \
    person_compositions := .compositions.title, \
    person_tracks := .tracks.title, \
}"

# Select people in the database.
@people *instance:
    {{query_command}} "{{select_person}}" {{instance}}

# Select a person in the database.
@person full_name *instance:
    {{query_command}} \
        "{{select_person}} filter .full_name ilike '%{{full_name}}%'" \
        {{instance}}

select_instrument := "\
select Instrument { \
    name, \
    instrument_players := .players.person.full_name \
}"

# Select instruments in the database.
@instruments *instance:
    {{query_command}} "{{select_instrument}}" {{instance}}

# Select an instrument in the database.
@instrument name *instance:
    {{query_command}} \
        "{{select_instrument}} filter .name ilike '%{{name}}%'" \
        {{instance}}

select_composition := "\
select Composition { \
    title, \
    date := .date_composed.local_date, \
    creators := .composers.full_name, \
    instruments := .instrumentation.name, \
}"

# Select compositions in the database.
@compositions *instance:
    {{query_command}} \
        "{{select_composition}}" \
        {{instance}}

# Select a composition in the database.
@composition title *instance:
    {{query_command}} \
        "{{select_composition}} filter .title ilike '%{{title}}%'" \
        {{instance}}

select_player := "\
select Player { \
    instrument_played := .instrument.name, \
    performer := .person.full_name, \
}"

# Select players in the database.
@players *instance:
    {{query_command}} \
        "{{select_player}}" \
        {{instance}}

# Select a player in the database.
@player name *instance:
    {{query_command}} \
        "{{select_player}} filter .person.full_name ilike '%{{name}}%'" \
        {{instance}}

select_artist := "\
select Artist { \
    name, \
    people := .members.full_name, \
    albums_made := .albums.title, \
}"

# Select artists in the database.
@artists *instance:
    {{query_command}} "{{select_artist}}" {{instance}}

# Select an artist in the database.
@artist name *instance:
    {{query_command}} \
        "{{select_artist}} filter .name ilike '%{{name}}%'" \
        {{instance}}

select_track := "\
select Track { \
    title, \
    duration, \
    number, \
    people := .players.display, \
    track_date_recorded := .date_recorded.local_date, \
}"

# Select tracks in the database.
@tracks *instance:
    {{query_command}} "{{select_track}}" {{instance}}

# Select a track in the database.
@track title *instance:
    {{query_command}} \
        "{{select_track}} filter .title ilike '%{{title}}%'" \
        {{instance}}

select_label := "\
select Label { \
    name, \
    label_series := .series.name, \
    label_albums := .albums.title, \
    label_artists := .artists.name \
}"

# Select labels in the database.
@labels *instance:
    {{query_command}} "{{select_label}}" {{instance}}

# Select a label in the database.
@label name *instance:
    {{query_command}} \
        "{{select_label}} filter .name ilike '%{{name}}%'" \
        {{instance}}

select_series := "\
select Series { \
    name, \
    series_label := .label.name, \
    series_albums := .albums.title, \
}"

# Select series in the database.
@series *instance:
    {{query_command}} "{{select_series}}" {{instance}}

# Select a series in the database.
@series-single name *instance:
    {{query_command}} \
        "{{select_series}} filter .name ilike '%{{name}}%'" \
        {{instance}}

select_disc := "\
select Disc { \
    title, \
    tracks: { title, duration, number} order by .number, \
    duration, \
}"

# Select discs in the database.
@discs *instance:
    {{query_command}} "{{select_disc}}" {{instance}}

# Select a disc in the database.
@disc title *instance:
    {{query_command}} \
        "{{select_disc}} filter .title ilike '%{{title}}%'" \
        {{instance}}

select_album := "\
select Album { \
    title, \
    album_artists := .artists.name, \
    disc_total, \
    album_tracks := .tracks.title, \
    duration, \
    album_label := .label.name, \
    producer := .producers.full_name, \
    catalog_number, \
    series_name := .series.name, \
    series_number, \
}"

# Select albums in the database.
@albums *instance:
    {{query_command}} "{{select_album}}" {{instance}}

# Select an album in the database.
@album title *instance:
    {{query_command}} \
        "{{select_album}} filter .title ilike '%{{title}}%'" \
        {{instance}}
