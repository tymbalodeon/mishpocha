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
}

module default {
    type Date {
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
            to_str([<str>.year, <str>.month, <str>.day], "-")
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

        property full_name := (
            (
                .first_name ++ ' '
                if .first_name != '' else
                ''
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
        multi link instruments := (
            with id := .id
            select Instrument
            filter .players.person.id = id
        );
        multi link groups := .<members[is Artist];
    }

    scalar type NoteName extending enum<C, D, E, F, G, A, B>;
    scalar type Accidental extending enum<flat, natrual, sharp>;

    type Note {
        name: NoteName;
        accidental: Accidental;

        constraint exclusive on ((.name, .accidental));
    }

    type Instrument {
        name: str;
        multi aliases: str;
        tuning: Note;

        constraint exclusive on ((.name, .tuning));

        multi link players := .<instrument[is Player];
    }

    scalar type Mode extending enum<major, minor>;

    type Key {
        root: Note;
        mode: Mode;

        constraint exclusive on ((.root, .mode));
    }

    scalar type Denominator extending enum<1, 2, 4, 8, 16, 32, 64>;

    type TimeSignature {
        numerator: int16;
        denominator: Denominator;

        constraint exclusive on ((.numerator, .denominator));
    }

    type Composition {
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
    }

    type Player {
        person: Person {
            on target delete delete source
        };
        instrument: Instrument {
            on target delete delete source
        };

        constraint exclusive on ((.person, .instrument));
    }

    type Artist {
        name: str;
        multi members: Person;
        date_start: Date;
        date_end: Date;
        multi link albums := .<artists[is Album];
    }

    type Track {
        title: str {
            rewrite insert, update using (
                with id := .id
                select __subject__.title
                ?? to_str(
                    array_agg(
                        (
                            select Track filter .id = id limit 1
                        ).compositions.title
                    ),
                ",")
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
    }

    type Series {
        name: str;
        label: Label;
    }

    type Label {
        name: str;

        multi link series := .<label[is Series];
        multi link albums := .<label[is Album];
        multi link artists := .albums.artists;
    }

    type Disc {
        title: str;
        number: int32 {
            constraint min_value(1);
        };
        multi tracks: Track;
    }

    type Album {
        title: str;
        multi artists: Artist;
        multi producers: Person;
        multi discs: Disc;
        label: Label;
        series: Series;
        series_number: int32;
        date_released: Date;
        date_recorded: Date;

        property disc_total := (
            count(.discs)
        );
    }
};
