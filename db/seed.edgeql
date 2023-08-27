with dates := <json>(
    { day := 3, month := 11, year := 1939 },
    { day := 5, month := 4, year := 1944 },
    { day := 8, month := 3, year := 1947 },
    { day := 22, month := 4, year := 1947 },
    { day := 18, month := 6, year := 1995 },
) for date in json_array_unpack(dates) union (
    insert Date {
        day := <int16>date["day"],
        month := <int16>date["month"],
        year := <int32>date["year"]
    } unless conflict
);

with people := <json>(
    {
        first_name := "Evan",
        last_name := "Parker",
        birth_date_display := "1944-4-5"
    },
    {
        first_name := "Paul",
        last_name := "Lytton",
        birth_date_display := "1947-3-8"
    },
    {
        first_name := "Barry",
        last_name := "Guy",
        birth_date_display := "1947-4-22"
    },
    {
        first_name := "Joe",
        last_name := "McPhee",
        birth_date_display := "1939-11-3"
    },
    {
        first_name := "Robert",
        last_name := "Rusch",
        birth_date_display := "1943-4-3"
    },
) for person in json_array_unpack(people) union (
    with existing_person := (
        select Person
        filter {
            .first_name = <str>person["first_name"],
            .last_name = <str>person["last_name"]
        } limit 1
    ), inserts := (
        person if not exists existing_person else <json>{}
    )
    for non_existing_person in inserts union (
        insert Person {
            first_name := <str>person["first_name"],
            last_name := <str>person["last_name"],
            birth_date := (
                select Date
                filter .display = <str>person["birth_date_display"]
                limit 1
            )
        }
    )
);

with instruments := <json>(
    { name := "trumpet" },
    { name := "soprano saxophone" },
    { name := "tenor saxophone" },
    { name := "bass" },
    { name := "drums" },
) for instrument in json_array_unpack(instruments) union (
    with existing_instrument := (
        select Instrument
        filter .name = <str>instrument["name"]
        limit 1
    ), inserts := (
        instrument if not exists existing_instrument else <json>{}
    ) for non_existing_instrument in inserts union (
        insert Instrument {
            name := <str>instrument["name"],
        }
    )
);

with players := <json>(
    {
        person_name := "Evan Parker",
        instrument_name := "soprano saxophone",
    },
    {
        person_name := "Evan Parker",
        instrument_name := "tenor saxophone",
    },
    {
        person_name := "Barry Guy",
        instrument_name := "bass",
    },
    {
        person_name := "Paul Lytton",
        instrument_name := "drums",
    },
    {
        person_name := "Joe McPhee",
        instrument_name := "trumpet",
    },
) for player in json_array_unpack(players) union (
    insert Player {
        person := (
            select Person
            filter .full_name = <str>player["person_name"]
            limit 1
        ),
        instrument := (
            select Instrument
            filter .name = <str>player["instrument_name"]
            limit 1
        )
    } unless conflict
);

with compositions := <json>(
    {
        title := "Not Yet",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        date_composed := { day := 18, month := 6, year := 1995 },
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "drums" },
        )
    },
    {
        title := "The Masks",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        date_composed := { day := 18, month := 6, year := 1995 },
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "drums" },
        )
    },
    {
        title := "Craig's Story",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        date_composed := { day := 18, month := 6, year := 1995 },
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "drums" },
        )
    },
    {
        title := "Pedal (For Warren)",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        date_composed := { day := 18, month := 6, year := 1995 },
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "drums" },
        )
    },
    {
        title := "Then Paul Saw the Snake (for Susan)",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
            { full_name := "Joe McPhee"},
        ),
        date_composed := { day := 18, month := 6, year := 1995 },
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "trumpet" },
            { name := "bass" },
            { name := "drums" },
        )
    },
) for composition in json_array_unpack(compositions) union (
    with existing_composition := (
        select Composition
        filter .title = <str>composition["title"]
        limit 1
    ), inserts := (
        composition if not exists existing_composition else <json>{}
    ) for non_existing_composition in inserts union (
        insert Composition {
            title := <str>composition["title"],
            composers := distinct (
                for composer in json_array_unpack(composition["composers"]) union (
                    select Person
                    filter .full_name = <str>composer["full_name"]
                )
            ),
            date_composed := (
                select Date
                filter {
                    .day = <int16>composition["date_composed"]["day"],
                    .month = <int16>composition["date_composed"]["month"],
                    .year = <int32>composition["date_composed"]["year"]
                }
                limit 1
            ),
            instrumentation := distinct (
                for instrument in json_array_unpack(composition["instrumentation"]) union (
                    select Instrument
                    filter .name = <str>instrument["name"]
                )
            )
        }
    )
);

with tracks := <json>(
    {
        compositions := ({ title := "Not Yet"},),
        number := 1,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        ),
        date_recorded := { day := 18, month := 6, year := 1995 },
        duration := "12 minutes 47 seconds"
    },
    {
        compositions := ({ title := "The Masks"},),
        number := 2,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        ),
        date_recorded := { day := 18, month := 6, year := 1995 },
        duration := "10 minutes 47 seconds"
    },
    {
        compositions := ({ title := "Craig's Story"},),
        number := 3,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        ),
        date_recorded := { day := 18, month := 6, year := 1995 },
        duration := "14 minutes 10 seconds"
    },
    {
        compositions := ({ title := "Pedal (For Warren)"},),
        number := 4,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        ),
        date_recorded := { day := 18, month := 6, year := 1995 },
        duration := "9 minutes 22 seconds"
    },
    {
        compositions := ({ title := "Then Paul Saw the Snake (for Susan)"},),
        number := 5,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
            { full_name := "Joe McPhee", instrument := "trumpet" },
        ),
        date_recorded := { day := 18, month := 6, year := 1995 },
        duration := "11 minutes 59 seconds"
    },
) for track in json_array_unpack(tracks) union (
    with existing_track := (
        select Track
        filter .number = <int16>track["number"]
        limit 1
    ), inserts := (
        track if not exists existing_track else <json>{}
    ) for non_existing_track in inserts union (
        insert Track {
            compositions  := distinct (
                for composition in json_array_unpack(track["compositions"]) union (
                    select Composition
                    filter .title = <str>composition["title"]
                )
            ),
            number := <int16>track["number"],
            players := distinct (
                for player in json_array_unpack(track["players"]) union (
                    select Player
                    filter {
                        .person.full_name = <str>player["full_name"],
                        .instrument.name = <str>player["instrument"]
                    }
                )
            ),
            date_recorded := (
                select Date
                filter {
                    .day = <int16>track["date_recorded"]["day"],
                    .month = <int16>track["date_recorded"]["month"],
                    .year = <int32>track["date_recorded"]["year"]
                }
                limit 1
            ),
            duration := <duration>track["duration"]
        }
    )
);

with artists := <json>(
    {
        member_names := (
            "Evan Parker",
            "Barry Guy",
            "Paul Lytton",
        )
    },
) for artist in json_array_unpack(artists) union (
    with existing_artist := (
        select Artist
        filter contains(<array<str>>artist["member_names"], .name)
        limit 1
    ), inserts := (
        artist if not exists existing_artist else <json>{}
    ) for non_existing_artist in inserts union (
        insert Artist {
            members := (
                select Person
                filter contains(<array<str>>artist["member_names"], .full_name)
            )
        }
    )
);

with discs := <json>(
    {
        album_title := "The Redwood Session",
        track_names := {
            "Not Yet",
            "The Masks",
            "Craig's Story",
            "Pedal (For Warren)",
            "Then Paul Saw the Snake (for Susan)",
        }
    },
) for disc in json_array_unpack(discs) union (
    with existing_disc := (
        select Disc
        filter .title = <str>disc["album_title"]
        limit 1
    ), inserts := (
        disc if not exists existing_disc else <json>{}
    ) for non_existing_disc in inserts union (
        insert Disc {
            tracks := (
                select Track
                filter contains(<array<str>>disc["track_names"], .title)
            )
        }
    )
);

with series_list := <json>(
    { name := "Spirit Room Series" },
) for series in json_array_unpack(series_list) union (
    with existing_series := (
        select Series
        filter .name = <str>series["name"]
        limit 1
    ), inserts := (
        series if not exists existing_series else <json>{}
    ) for non_existing_series in inserts union (
        insert Series {
            name := <str>series["name"],
        }
    )
);

with labels := <json>(
    {
        name := "CIMP",
        series_name := "Spirit Room Series"
    },
) for label in json_array_unpack(labels) union (
    with existing_label := (
        select Label
        filter .name = <str>label["name"]
        limit 1
    ), inserts := (
        label if not exists existing_label else <json>{}
    ) for non_existing_label in inserts union (
        insert Label {
            name := <str>label["name"],
            series := (
                select Series
                filter .name = <str>label["series_name"]
                limit 1
            ),
        }
    )
);

with albums := <json>(
    {
        title := "The Redwood Session",
        artist_name := "Evan Parker, Paul Lytton, Barry Guy",
        producer_name := "Robert Rusch",
        catalog_number := 101,
        series_name := "Spirit Room Series",
        series_number := 1,
        label_name := "CIMP"
    },
) for album in json_array_unpack(albums) union (
    with existing_album := (
        select Album
        filter .title = <str>album["title"]
        limit 1
    ), inserts := (
        album if not exists existing_album else <json>{}
    ) for non_existing_album in inserts union (
        insert Album {
            title := <str>album["title"],
            series := (
                select Series
                filter .name = <str>album["series_name"]
                limit 1
            ),
            series_number := <int32>album["series_number"],
            catalog_number := <int32>album["catalog_number"],
            artists := (
                select Artist
                filter .name = <str>album["artist_name"]
                limit 1
            ),
            discs := (
                select Disc
            ),
            producers := (
                select Person
                filter .full_name = <str>album["producer_name"]
                limit 1
            ),
            label := (
                select Label
                filter .name = <str>album["label_name"]
                limit 1
            )
        }
    )
);

