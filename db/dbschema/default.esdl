module default {
    function get_date_element(
        local_date: cal::local_date, element: str
    ) -> float64
        using (cal::date_get(local_date, element));
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

        multi link birthdays := .<birth_date[is Person];
        multi link deathdays := .<death_date[is Person];
        multi link compositions := .<composition_date[is Composition];
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
        multi link compositions := .<composers[is Composition];
        multi link arrangements := .<arrangers[is Composition];
        multi link lyrics := .<lyricists[is Composition];
        property is_composer := count(.compositions) > 0;
        property is_arranger := count(.arrangements) > 0;
        property is_lyricist := count(.lyrics) > 0;
        property is_player := count(.<person[is Player]) > 0;
        multi link instruments := (
            with id := .id
            select Instrument
            filter (
                select Player
                filter .person.id = id
            )
            in .players
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
        aliases: array<str>;
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
        multi composers: Person;
        multi lyricists: Person;
        multi arrangers: Person;
        composition_date: Date;
        arrangement_date: cal::local_date;
        multi instrumentation: Instrument;
        key: Key;
        time_signature: TimeSignature;
    }

    type Player {
        person: Person;
        instrument: Instrument;

        constraint exclusive on ((.person, .instrument));
    }

    type Artist {
        name: str;
        multi members: Person;
        year_start: cal::local_date;
        year_end: cal::local_date;
        multi link albums := .<artists[is Album];
    }

    type Track {
        title: str {
            rewrite insert, update using (
                __subject__.title
                ?? to_str(
                    array_agg((
                    with track := (select Track limit 1)
                    select Composition.title
                    filter contains(
                        array_agg(track.compositions), Composition
                    ))
                ), ",")
            )
        };
        multi compositions: Composition;
        multi players: Player;
        year_recorded: cal::local_date;
        year_released: cal::local_date;
        year_mastered: cal::local_date;
        year_mixed: cal::local_date;
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
        multi link artists := (
            with albums := .albums,
            albums := (select Album filter Album in albums),
            select albums.artists
        );
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

        property disc_total := (
            count(.discs)
        );
    }
};
