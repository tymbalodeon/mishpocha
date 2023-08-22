with dates := <json>(
    { day := 3, month := 11, year := 1939 },
    { day := 5, month := 4, year := 1944 },
    { day := 8, month := 3, year := 1947 },
    { day := 22, month := 4, year := 1947 },
),
for date in json_array_unpack(dates) union (
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
),
for person in json_array_unpack(people) union (
    insert Person {
        first_name := <str>person["first_name"],
        last_name := <str>person["last_name"],
        birth_date := (
            select Date
            filter .display = <str>person["birth_date_display"]
            limit 1
        )
    } unless conflict
);

with instruments := <json>(
    { name := "trumpet" },
    { name := "soprano saxophone" },
    { name := "tenor saxophone" },
    { name := "bass" },
    { name := "drums" },
),
for instrument in json_array_unpack(instruments) union (
    insert Instrument {
        name := <str>instrument["name"],
    } unless conflict
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
),
for player in json_array_unpack(players) union (
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


with tracks := <json>(
    {
        title := "Not Yet",
        number := 1,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        )
    },
    {
        title := "The Masks",
        number := 2,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        )
    },
    {
        title := "Craig's Story",
        number := 3,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        )
    },
    {
        title := "Pedal (for Warren)",
        number := 4,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
        )
    },
    {
        title := "Then Paul saw the Snake (for Susan)",
        number := 5,
        players := (
            { full_name := "Evan Parker", instrument := "soprano saxophone" },
            { full_name := "Barry Guy", instrument := "bass" },
            { full_name := "Paul Lytton", instrument := "drums" },
            { full_name := "Joe McPhee", instrument := "trumpet" },
        )
    },
)
for track in json_array_unpack(tracks) union (
    insert Track {
        title := <str>track["title"],
        number := <int16>track["number"],
        players := distinct (
            for player in json_array_unpack(track["players"]) union (
                select Player
                filter {
                    .person.full_name = <str>player["full_name"],
                    .instrument.name = <str>player["instrument"]
                }
            )
        )
    } unless conflict
);
