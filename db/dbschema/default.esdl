module default {
    function get_date_element(
        local_date: cal::local_date, element: str
    ) -> float64
        using (cal::date_get(local_date, element));

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

        property display := {
            to_str([<str>.year, <str>.month, <str>.day], "-")
        };
        property local_date := {
            cal::to_local_date(.year, .month, .day)
        };
    }

    type Person {
        first_name: str;
        last_name: str;
        aliases: array<str>;
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
            ), age := (
                latest_year - .birth_date.year
            ) select age
                if latest_month >= .birth_date.month
                and latest_day >= .birth_date.day
                else age - 1
        );
        multi link instruments := (
            with id := .id
            select Instrument
            filter (
                select Player
                filter .person.id = id
            )
            in .players
        );
    }

    scalar type NoteName extending enum<C, D, E, F, G, A, B>;
    scalar type Accidental extending enum<flat, natrual, sharp>;

    type Note {
        name: NoteName;
        accidental: Accidental;
    }

    type Instrument {
        name: str;
        aliases: array<str>;
        tuning: Note;

        multi link players := .<instrument[is Player];
    }

    scalar type Mode extending enum<major, minor>;

    type Key {
        root: Note;
        mode: Mode;
    }

    scalar type Denominator extending enum<1, 2, 4, 8, 16, 32, 64>;

    type TimeSignature {
        numerator: int16;
        denominator: Denominator;
    }

    type Composition {
        title: str;
        multi composer: Person;
        multi lyricist: Person;
        multi arranger: Person;
        composition_date: cal::local_date;
        arrangement_date: cal::local_date;
        multi instrumentation: Instrument;
        key: Key;
        time_signature: TimeSignature;
    }

    type Player {
        person: Person;
        instrument: Instrument;
    }

    type Artist {
        name: str;
        multi members: Person;
        year_start: cal::local_date;
        year_end: cal::local_date;
    }

    type Track {
        title: str;
        multi compositions: Composition;
        multi players: Player;
        year_recorded: cal::local_date;
        year_released: cal::local_date;
        year_mastered: cal::local_date;
        year_mixed: cal::local_date;
        number: int16;
        duration: duration;
  }

    type Album {
        title: str;
        multi artist: Artist;
        multi tracks: Track;
    }
};
