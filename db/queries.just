!include helpers.just

@_help:
    {{just}} --justfile queries.just --list

bat := "bat --style plain --language json --theme gruvbox-dark"
jq := "jq | " + bat


# Delete all objects in the database.
@delete:
    {{connect_to_edgedb}} query \
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
        | {{jq}}

select_date := "\
select Date { \
    local_date, \
    birthdays := .births.full_name \
}"

# Select dates in the database.
@dates:
    {{connect_to_edgedb}} query "{{select_date}}" | {{jq}}

# Select a date in the database.
@date display:
    {{connect_to_edgedb}} query \
        "{{select_date}} filter .display ilike '%{{display}}%'" \
        | {{jq}}

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
};"

# Select people in the database.
@people:
    {{connect_to_edgedb}} query "{{select_person}}" | {{jq}}

# Select a person in the database.
@person full_name:
    {{connect_to_edgedb}} query \
        "{{select_person}} filter .full_name ilike '%{{full_name}}%'" \
        | {{jq}}

select_instrument := "\
select Instrument { \
    name, \
    instrument_players := .players.person.full_name \
};"

# Select instruments in the database.
@instruments:
    {{connect_to_edgedb}} query "{{select_instrument}}" | {{jq}}

# Select an instrument in the database.
@instrument name:
    {{connect_to_edgedb}} query \
        "{{select_instrument}} filter .name ilike '%{{name}}%'" \
        | {{jq}}

select_composition := "\
select Composition { \
    title, \
    date := .date_composed.local_date, \
    creators := .composers.full_name, \
    instruments := .instrumentation.name, \
};"

# Select compositions in the database.
@compositions:
    {{connect_to_edgedb}} query \
        "{{select_composition}}" \
        | {{jq}}

# Select a composition in the database.
@composition title:
    {{connect_to_edgedb}} query \
        "{{select_composition}} filter .title ilike '%{{title}}%'" \
        | {{jq}}

select_player := "\
select Player { \
    instrument_played := .instrument.name, \
    performer := .person.full_name, \
};"

# Select players in the database.
@players:
    {{connect_to_edgedb}} query \
        "{{select_player}}" \
        | {{jq}}

# Select a player in the database.
@player name:
    {{connect_to_edgedb}} query \
        "{{select_player}} filter .person.full_name ilike '%{{name}}%'" \
        | {{jq}}

select_artist := "\
select Artist { \
    name, \
    people := .members.full_name, \
    albums_made := .albums.title, \
};"

# Select artists in the database.
@artists:
    {{connect_to_edgedb}} query "{{select_artist}}" | {{jq}}

# Select an artist in the database.
@artist name:
    {{connect_to_edgedb}} query \
        "{{select_artist}} filter .name ilike '%{{name}}%'" \
        | {{jq}}

select_track := "\
select Track { \
    title, \
    duration, \
    number, \
    people := .players.display, \
    track_date_recorded := .date_recorded.local_date, \
};"

# Select tracks in the database.
@tracks:
    {{connect_to_edgedb}} query "{{select_track}}" | {{jq}}

# Select a track in the database.
@track title:
    {{connect_to_edgedb}} query \
        "{{select_track}} filter .title ilike '%{{title}}%'" \
        | {{jq}}

select_label := "\
select Label { \
    name, \
    label_series := .series.name, \
    label_albums := .albums.title, \
    label_artists := .artists.name \
};"

# Select labels in the database.
@labels:
    {{connect_to_edgedb}} query "{{select_label}}" | {{jq}}

# Select a label in the database.
@label name:
    {{connect_to_edgedb}} query \
        "{{select_label}} filter .name ilike '%{{name}}%'" \
        | {{jq}}

select_series := "\
select Series { \
    name, \
    series_label := .label.name, \
    series_albums := .albums.title, \
};"

# Select series in the database.
@series:
    {{connect_to_edgedb}} query "{{select_series}}" | {{jq}}

# Select a series in the database.
@series-single name:
    {{connect_to_edgedb}} query \
        "{{select_series}} filter .name ilike '%{{name}}%'" \
        | {{jq}}

select_disc := "\
select Disc { \
    title, \
    tracks: { title, duration, number} order by .number, \
    duration, \
};"

# Select discs in the database.
@discs:
    {{connect_to_edgedb}} query "{{select_disc}}" | {{jq}}

# Select a disc in the database.
@disc title:
    {{connect_to_edgedb}} query \
        "{{select_disc}} filter .title ilike '%{{title}}%'" \
        | {{jq}}

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
};"

# Select albums in the database.
@albums:
    {{connect_to_edgedb}} query "{{select_album}}" | {{jq}}

# Select an album in the database.
@album title:
    {{connect_to_edgedb}} query \
        "{{select_album}} filter .title ilike '%{{title}}%'" \
        | {{jq}}
