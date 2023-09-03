module default {
    function get_date_element(
        local_date: cal::local_date, element: str
    ) -> float64 using (
        cal::date_get(local_date, element)
    );

    function get_age(
        person_year: float64,
        person_month: float64,
        person_day: float64,
        date_year: float64,
        date_month: float64,
        date_day: float64
    ) -> set of float64 using (
        with age := date_year - person_year
        select age
        if date_month >= person_month
        and date_day >= person_day
        else age - 1
    );

    function get_age_when(person: Person, date: Date) -> set of float64 using (
        get_age(
            date.year,
            date.month,
            date.day,
            person.birth_date.year,
            person.birth_date.month,
            person.birth_date.day,
        )
    );

    function get_totalseconds(duration: duration) -> float64 using (
        duration_get(duration, "totalseconds")
    );

    function get_duration_from_seconds(seconds: float64) -> duration using (
        to_duration(seconds := seconds)
    );
}

module default {
    abstract property type_name {
        readonly := true;
    }
}

module default {
    type Date {
        type_name: str {
            extending type_name;
            default := "date"
        };

        day: int16 {
            constraint min_value(1);
            constraint max_value(31);
        };
        month: int16 {
            constraint min_value(1);
            constraint max_value(12);
        };
        year: int32;

        constraint exclusive on ((.day, .month, .year));

        property display := {
            <str>.local_date
        };
        property local_date := {
            cal::to_local_date(.year, .month, .day)
        };

        multi link births := .<birth_date[is Person];
        multi link deaths := .<death_date[is Person];
        multi link artist_starts := .<date_start[is Artist];
        multi link artist_ends := .<date_end[is Artist];
        multi link compositions := .<date_composed[is Composition];
        multi link arrangements := .<date_arranged[is Composition];
        multi link tracks_recorded := .<date_recorded[is Track];
        multi link tracks_released := .<date_released[is Track];
        multi link tracks_mastered := .<date_mastered[is Track];
        multi link tracks_mixed := .<date_mixed[is Track];
        multi link albums_released := .<date_released[is Album];
    }

    type Person {
        type_name: str {
            extending type_name;
            default := "person"
        };

        first_name: str;
        last_name: str;
        multi aliases: str;
        birth_date: Date;
        death_date: Date;
        is_alive: bool {
            rewrite insert, update using (
                __subject__.is_alive ?? not exists __subject__.death_date
            )
        };

        property display := .full_name;
        property full_name := (
            (
                .first_name ++ " "
                if .first_name != "" else
                ""
            ) ++ .last_name
        );
        property age := (
            with current_date := (
                cal::to_local_date(datetime_of_statement(), "UTC")
            ), current_year := (
                get_date_element(current_date, "year")
            ), current_month := (
                get_date_element(current_date, "month")
            ), current_day := (
                get_date_element(current_date, "day")
            ), latest_year := (
                .death_date.year ?? current_year
            ), latest_month := (
                .death_date.month ?? current_month
            ), latest_day := (
                .death_date.day ?? current_day
            ) select get_age(
                .birth_date.year,
                .birth_date.month,
                .birth_date.day,
                latest_year,
                latest_month,
                latest_day
            )
        );
        multi link compositions := .<composers[is Composition];
        multi link arrangements := .<arrangers[is Composition];
        multi link lyrics := .<lyricists[is Composition];
        multi link tracks := .<person[is Player].<players[is Track];
        property is_composer := count(.compositions) > 0;
        property is_arranger := count(.arrangements) > 0;
        property is_lyricist := count(.lyrics) > 0;
        property is_player := count(.<person[is Player]) > 0;
        property is_producer := count(.<producers[is Album]) > 0;
        multi link instruments := (
            with id := .id
            select Instrument
            filter .players.person.id = id
        );
        multi link artists := .<members[is Artist];
    }

    scalar type NoteName extending enum<C, D, E, F, G, A, B>;
    scalar type Accidental extending enum<flat, natrual, sharp>;

    type Note {
        type_name: str {
            extending type_name;
            default := "note"
        };

        name: NoteName;
        accidental: Accidental;

        property display := <str>.name ++ " " ++ <str>.accidental;

        constraint exclusive on ((.name, .accidental));
    }

    type Instrument {
        type_name: str {
            extending type_name;
            default := "instrument"
        };

        name: str;
        multi aliases: str;
        tuning: Note;

        constraint exclusive on ((.name, .tuning));

        property display := (
            with tuning := .tuning.display
            select (
                tuning ++ " "
                if exists tuning else
                ""
            ) ++ .name
        );
        multi link players := .<instrument[is Player];
    }

    scalar type Mode extending enum<major, minor>;

    type Key {
        type_name: str {
            extending type_name;
            default := "key"
        };

        root: Note;
        mode: Mode;

        constraint exclusive on ((.root, .mode));

        property display := .root.display ++ " " ++ <str>.mode;
    }

    scalar type Denominator extending enum<1, 2, 4, 8, 16, 32, 64>;

    type TimeSignature {
        type_name: str {
            extending type_name;
            default := "time_signature"
        };

        numerator: int16;
        denominator: Denominator;

        constraint exclusive on ((.numerator, .denominator));

        property display := <str>.numerator ++ "/" ++ <str>.denominator;
    }

    type Composition {
        type_name: str {
            extending type_name;
            default := "composition"
        };

        title: str;
        multi composers: Person {
            on target delete allow
        };
        multi lyricists: Person;
        multi arrangers: Person;
        date_composed: Date;
        date_arranged: Date;
        multi instrumentation: Instrument {
            on target delete allow
        };
        key: Key;
        time_signature: TimeSignature;

        property display := .title;
    }

    type Player {
        type_name: str {
            extending type_name;
            default := "player"
        };

        person: Person {
            on target delete delete source
        };
        instrument: Instrument {
            on target delete delete source
        };

        constraint exclusive on ((.person, .instrument));

        property display := .person.display ++ " (" ++ .instrument.display ++ ")"
    }

    type Artist {
        type_name: str {
            extending type_name;
            default := "artist"
        };

        name: str {
            rewrite insert, update using (
                with id := .id
                select __subject__.name
                ?? (
                    with members := (
                        __subject__.members
                        ?? (
                            select Artist.members
                            filter .id = id
                            limit 1
                        )
                    ) select to_str(array_agg(members.full_name), ", ")
                )
            )
        };
        multi members: Person;
        date_start: Date;
        date_end: Date;
        multi link albums := .<artists[is Album];

        property display := .name
    }

    type Track {
        type_name: str {
            extending type_name;
            default := "track"
        };

        title: str {
            rewrite insert, update using (
                with id := .id
                select __subject__.title
                ?? (
                    with compositions  := (
                        __subject__.compositions
                        ?? (
                            select Track.compositions
                            filter .id = id
                            limit 1
                        )
                    ) select to_str(array_agg(compositions.title), ", ")
                )
            )
        };
        multi compositions: Composition {
            on target delete allow
        };

        multi players: Player {
            on target delete allow
        };
        date_recorded: Date;
        date_released: Date;
        date_mastered: Date;
        date_mixed: Date;
        number: int16;
        duration: duration;

        property display := .title
    }

    type Series {
        type_name: str {
            extending type_name;
            default := "series"
        };

        name: str;

        link label := .<series[is Label];
        multi link albums := .<series[is Album];

        property display := .name
    }

    type Label {
        type_name: str {
            extending type_name;
            default := "label"
        };

        name: str;
        multi series: Series;

        multi link albums := .<label[is Album];
        multi link artists := .albums.artists;

        property display := .name;
    }

    type Disc {
        type_name: str {
            extending type_name;
            default := "disc"
        };

        disc_title: str;
        number: int32 {
            constraint min_value(1);
        };
        multi tracks: Track;

        link album := .<discs[is Album];
        property title := .disc_title ?? .album.title;
        property duration := (
            with seconds := sum(get_totalseconds(.tracks.duration))
            select get_duration_from_seconds(seconds)
        );

        property display := .title;
    }

    type Album {
        type_name: str {
            extending type_name;
            default := "album"
        };

        title: str;
        multi artists: Artist;
        multi producers: Person;
        multi discs: Disc;
        label: Label;
        catalog_number: int64;
        series: Series;
        series_number: int64;
        date_released: Date;
        date_recorded: Date;

        property display := .title;
        multi link tracks := .discs.tracks;
        property disc_total := count(.discs);
        property duration := (
            with seconds := sum(get_totalseconds(.discs.duration))
            select get_duration_from_seconds(seconds)
        );
    }
};
