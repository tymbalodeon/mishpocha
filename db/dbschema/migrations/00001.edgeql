CREATE MIGRATION m1pvkwsgdaecs6yt5pune3thpw6gx6if5mcyls7keoai4uevebqytq
    ONTO initial
{
  CREATE FUNCTION default::get_year(local_date: cal::local_date) ->  std::float64 USING (cal::date_get(local_date, 'year'));
  CREATE SCALAR TYPE default::Accidental EXTENDING enum<flat, natrual, sharp>;
  CREATE SCALAR TYPE default::NoteName EXTENDING enum<C, D, E, F, G, A, B>;
  CREATE TYPE default::Note {
      CREATE PROPERTY accidental: default::Accidental;
      CREATE PROPERTY name: default::NoteName;
  };
  CREATE TYPE default::Person {
      CREATE PROPERTY birth_date: cal::local_date;
      CREATE PROPERTY death_date: cal::local_date;
      CREATE PROPERTY age := (WITH
          latest_date := 
              (.death_date ?? cal::to_local_date(std::datetime_of_statement(), 'UTC'))
      SELECT
          (default::get_year(latest_date) - default::get_year(.birth_date))
      );
      CREATE PROPERTY aliases: array<std::str>;
      CREATE PROPERTY is_alive: std::bool {
          CREATE REWRITE
              INSERT 
              USING ((__subject__.is_alive ?? NOT (EXISTS (__subject__.death_date))));
          CREATE REWRITE
              UPDATE 
              USING ((__subject__.is_alive ?? NOT (EXISTS (__subject__.death_date))));
      };
      CREATE PROPERTY first_name: std::str;
      CREATE PROPERTY last_name: std::str;
      CREATE PROPERTY full_name := ((((.first_name ++ ' ') IF (.first_name != '') ELSE '') ++ .last_name));
  };
  CREATE TYPE default::Artist {
      CREATE MULTI LINK members: default::Person;
      CREATE PROPERTY name: std::str;
      CREATE PROPERTY year_end: cal::local_date;
      CREATE PROPERTY year_start: cal::local_date;
  };
  CREATE TYPE default::Album {
      CREATE MULTI LINK artist: default::Artist;
      CREATE PROPERTY title: std::str;
  };
  CREATE TYPE default::Track {
      CREATE PROPERTY duration: std::duration;
      CREATE PROPERTY number: std::int16;
      CREATE PROPERTY title: std::str;
      CREATE PROPERTY year_mastered: cal::local_date;
      CREATE PROPERTY year_mixed: cal::local_date;
      CREATE PROPERTY year_recorded: cal::local_date;
      CREATE PROPERTY year_released: cal::local_date;
  };
  ALTER TYPE default::Album {
      CREATE MULTI LINK tracks: default::Track;
  };
  CREATE SCALAR TYPE default::Mode EXTENDING enum<major, minor>;
  CREATE TYPE default::Key {
      CREATE LINK root: default::Note;
      CREATE PROPERTY mode: default::Mode;
  };
  CREATE SCALAR TYPE default::Denominator EXTENDING enum<`1`, `2`, `4`, `8`, `16`, `32`, `64`>;
  CREATE TYPE default::TimeSignature {
      CREATE PROPERTY denominator: default::Denominator;
      CREATE PROPERTY numerator: std::int16;
  };
  CREATE TYPE default::Composition {
      CREATE MULTI LINK arranger: default::Person;
      CREATE MULTI LINK composer: default::Person;
      CREATE LINK key: default::Key;
      CREATE MULTI LINK lyricist: default::Person;
      CREATE LINK time_signature: default::TimeSignature;
      CREATE PROPERTY arrangement_date: cal::local_date;
      CREATE PROPERTY composition_date: cal::local_date;
      CREATE PROPERTY title: std::str;
  };
  CREATE TYPE default::Instrument {
      CREATE LINK tuning: default::Note;
      CREATE PROPERTY aliases: array<std::str>;
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Composition {
      CREATE MULTI LINK instrumentation: default::Instrument;
  };
  ALTER TYPE default::Track {
      CREATE MULTI LINK compositions: default::Composition;
  };
  CREATE TYPE default::Date {
      CREATE PROPERTY day: std::int16;
      CREATE PROPERTY month: std::int16;
      CREATE PROPERTY year: std::int16;
  };
  CREATE TYPE default::Player {
      CREATE LINK instrument: default::Instrument;
      CREATE LINK person: default::Person;
  };
  ALTER TYPE default::Instrument {
      CREATE MULTI LINK players := (.<instrument[IS default::Player]);
  };
  ALTER TYPE default::Person {
      CREATE MULTI LINK instruments := (WITH
          id := 
              .id
      SELECT
          default::Instrument
      FILTER
          ((SELECT
              default::Player
          FILTER
              (.person.id = id)
          ) IN .players)
      );
  };
  ALTER TYPE default::Track {
      CREATE MULTI LINK players: default::Player;
  };
};
