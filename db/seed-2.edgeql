with dates := <json>(
    { day := 6, month := 2, year := 1945 },
    { day := 11, month := 9, year := 1995 },
    { day := 12, month := 9, year := 1995 },
) for date in json_array_unpack(dates) union (
    insert Date {
        day := <int16>date["day"],
        month := <int16>date["month"],
        year := <int32>date["year"]
    } unless conflict
);

with people := <json>(
    {
        first_name := "Ernie",
        last_name := "Krivda",
    },
    {
        first_name := "Jeff",
        last_name := "Halsey",
    },
    {
        first_name := "Bob",
        last_name := "Fraser",
    },
    {
        first_name := "Marc",
        last_name := "Rusch",
    },
    {
        first_name := "Kara",
        last_name := "Rusch",
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
        }
    )
);

with instruments := <json>(
    { name := "guitar" },
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
        person_name := "Ernie Krivda",
        instrument_name := "tenor saxophone",
    },
    {
        person_name := "Jeff Halsey",
        instrument_name := "bass",
    },
    {
        person_name := "Bob Fraser",
        instrument_name := "guitar",
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
        title := "Sarah's Theme",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "guitar" },
        )
    },
    {
        title := "Interlude #1 (Musing on a Bass Stick)",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "guitar" },
        )
    },
    {
        title := "Stella by Starlight",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "guitar" },
        )
    },
    {
        title := "Interlude #2 (A winter's Tale)",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
        ),
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "guitar" },
        )
    },
    {
        title := "Pacific Echoes",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
            { full_name := "Joe McPhee"},
        ),
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "guitar" },
        )
    },
    {
        title := "Interlude #3 (Appalachian Summer)",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
            { full_name := "Joe McPhee"},
        ),
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "guitar" },
        )
    },
    {
        title := "Ernokee",
        composers := (
            { full_name := "Evan Parker"},
            { full_name := "Barry Guy"},
            { full_name := "Paul Lytton"},
            { full_name := "Joe McPhee"},
        ),
        instrumentation := (
            { name := "tenor saxophone" },
            { name := "bass" },
            { name := "guitar" },
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
        compositions := ({ title := "Sarah's Theme"},),
        number := 1,
        players := (
            { full_name := "Ernie Krivda", instrument := "tenor saxophone" },
            { full_name := "Jeff Halsey", instrument := "bass" },
            { full_name := "Bob Fraser", instrument := "guitar" },
        ),
        duration := "20 minutes 50 seconds"
    },
    {
        compositions := ({ title := "Interlude #1 (Musing on a Bass Stick)"},),
        number := 2,
        players := (
            { full_name := "Ernie Krivda", instrument := "tenor saxophone" },
            { full_name := "Jeff Halsey", instrument := "bass" },
            { full_name := "Bob Fraser", instrument := "guitar" },
        ),
        duration := "2 minutes 46 seconds"
    },
    {
        compositions := ({ title := "Stella by Starlight"},),
        number := 3,
        players := (
            { full_name := "Ernie Krivda", instrument := "tenor saxophone" },
            { full_name := "Jeff Halsey", instrument := "bass" },
            { full_name := "Bob Fraser", instrument := "guitar" },
        ),
        duration := "13 minutes 45 seconds"
    },
    {
        compositions := ({ title := "Interlude #2 (A winter's Tale)"},),
        number := 4,
        players := (
            { full_name := "Ernie Krivda", instrument := "tenor saxophone" },
            { full_name := "Jeff Halsey", instrument := "bass" },
            { full_name := "Bob Fraser", instrument := "guitar" },
        ),
        duration := "2 minutes 39 seconds"
    },
    {
        compositions := ({ title := "Pacific Echoes"},),
        number := 5,
        players := (
            { full_name := "Ernie Krivda", instrument := "tenor saxophone" },
            { full_name := "Jeff Halsey", instrument := "bass" },
            { full_name := "Bob Fraser", instrument := "guitar" },
        ),
        duration := "14 minutes 52 seconds"
    },
    {
        compositions := ({ title := "Interlude #3 (Appalachian Summer)"},),
        number := 5,
        players := (
            { full_name := "Ernie Krivda", instrument := "tenor saxophone" },
            { full_name := "Jeff Halsey", instrument := "bass" },
            { full_name := "Bob Fraser", instrument := "guitar" },
        ),
        duration := "2 minutes 24 seconds"
    },
    {
        compositions := ({ title := "Ernokee"},),
        number := 5,
        players := (
            { full_name := "Ernie Krivda", instrument := "tenor saxophone" },
            { full_name := "Jeff Halsey", instrument := "bass" },
            { full_name := "Bob Fraser", instrument := "guitar" },
        ),
        duration := "11 minutes 19 seconds"
    },
) for track in json_array_unpack(tracks) union (
    with existing_track := (
        select Track
        filter .duration = <duration>track["duration"]
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
            duration := <duration>track["duration"]
        }
    )
);

with artists := <json>(
    {
        name := "Ernie Krivda Trio",
        member_names := (
            "Ernie Krivda",
            "Jeff Halsey",
            "Bob Fraser",
        )
    },
) for artist in json_array_unpack(artists) union (
    with existing_artist := (
        select Artist
        filter contains(<array<str>>artist["member_names"], .members.full_name)
        limit 1
    ), inserts := (
        artist if not exists existing_artist else <json>{}
    ) for non_existing_artist in inserts union (
        insert Artist {
            name := <str>artist["name"],
            members := (
                select Person
                filter contains(<array<str>>artist["member_names"], .full_name)
            )
        }
    )
);

with discs := <json>(
    {
        album_title := "Sarah's Theme",
        track_names := {
            "Sarah's Theme",
            "Interlude #1 (Musing on a Bass Stick)",
            "Stella by Starlight",
            "Interlude #2 (A winter's Tale)",
            "Pacific Echoes",
            "Interlude #3 (Appalachian Summer)",
            "Ernokee",
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

with albums := <json>(
    {
        title := "Sarah's Theme",
        artist_name := "Ernie Krivda Trio",
        producer_name := "Robert Rusch",
        catalog_number := 102,
        series_name := "Spirit Room Series",
        series_number := 2,
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
            discs := (select Disc filter .tracks.title = "Sarah's Theme"),
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
