CREATE MIGRATION m1gdtcqmm7u5crofbqtmm3ltafzji4emvynubfmw3qpp6dih6bui3q
    ONTO initial
{
  CREATE FUNCTION default::get_date_element(local_date: cal::local_date, element: std::str) ->  std::float64 USING (cal::date_get(local_date, element));
  CREATE TYPE default::Date {
      CREATE PROPERTY day: std::int16 {
          CREATE CONSTRAINT std::max_value(31);
          CREATE CONSTRAINT std::min_value(1);
      };
      CREATE PROPERTY month: std::int16 {
          CREATE CONSTRAINT std::max_value(12);
          CREATE CONSTRAINT std::min_value(1);
      };
      CREATE PROPERTY year: std::int32;
      CREATE CONSTRAINT std::exclusive ON ((.day, .month, .year));
      CREATE PROPERTY display := ({std::to_str([<std::str>.year, <std::str>.month, <std::str>.day], '-')});
      CREATE PROPERTY local_date := ({cal::to_local_date(.year, .month, .day)});
  };
  CREATE SCALAR TYPE default::Accidental EXTENDING enum<flat, natrual, sharp>;
  CREATE SCALAR TYPE default::NoteName EXTENDING enum<C, D, E, F, G, A, B>;
  CREATE TYPE default::Note {
      CREATE PROPERTY accidental: default::Accidental;
      CREATE PROPERTY name: default::NoteName;
      CREATE CONSTRAINT std::exclusive ON ((.name, .accidental));
  };
  CREATE TYPE default::Person {
      CREATE LINK birth_date: default::Date;
      CREATE LINK death_date: default::Date;
      CREATE PROPERTY age := (WITH
          current_date := 
              cal::to_local_date(std::datetime_of_statement(), 'UTC')
          ,
          current_year := 
              default::get_date_element(current_date, 'year')
          ,
          current_month := 
              default::get_date_element(current_date, 'month')
          ,
          current_day := 
              default::get_date_element(current_date, 'day')
          ,
          latest_year := 
              (.death_date.year ?? current_year)
          ,
          latest_month := 
              (.death_date.month ?? current_month)
          ,
          latest_day := 
              (.death_date.day ?? current_day)
          ,
          age := 
              (latest_year - .birth_date.year)
      SELECT
          (age IF ((latest_month >= .birth_date.month) AND (latest_day >= .birth_date.day)) ELSE (age - 1))
      );
      CREATE PROPERTY is_alive: std::bool {
          CREATE REWRITE
              INSERT 
              USING ((__subject__.is_alive ?? NOT (EXISTS (__subject__.death_date))));
          CREATE REWRITE
              UPDATE 
              USING ((__subject__.is_alive ?? NOT (EXISTS (__subject__.death_date))));
      };
      CREATE MULTI PROPERTY aliases: std::str;
      CREATE PROPERTY first_name: std::str;
      CREATE PROPERTY last_name: std::str;
      CREATE PROPERTY full_name := ((((.first_name ++ ' ') IF (.first_name != '') ELSE '') ++ .last_name));
  };
  CREATE TYPE default::Album {
      CREATE LINK date_released: default::Date;
      CREATE MULTI LINK producers: default::Person;
      CREATE PROPERTY series_number: std::int32;
      CREATE PROPERTY title: std::str;
  };
  CREATE TYPE default::Artist {
      CREATE LINK date_end: default::Date;
      CREATE LINK date_start: default::Date;
      CREATE MULTI LINK members: default::Person;
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Album {
      CREATE MULTI LINK artists: default::Artist;
  };
  CREATE TYPE default::Label {
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Album {
      CREATE LINK label: default::Label;
  };
  ALTER TYPE default::Label {
      CREATE MULTI LINK albums := (.<label[IS default::Album]);
      CREATE MULTI LINK artists := (WITH
          albums := 
              .albums
          ,
          albums := 
              (SELECT
                  default::Album
              FILTER
                  (default::Album IN albums)
              )
      SELECT
          albums.artists
      );
  };
  ALTER TYPE default::Artist {
      CREATE MULTI LINK albums := (.<artists[IS default::Album]);
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK albums_released := (.<date_released[IS default::Album]);
      CREATE MULTI LINK artist_ends := (.<date_end[IS default::Artist]);
      CREATE MULTI LINK artist_starts := (.<date_start[IS default::Artist]);
  };
  CREATE TYPE default::Disc {
      CREATE PROPERTY number: std::int32 {
          CREATE CONSTRAINT std::min_value(1);
      };
      CREATE PROPERTY title: std::str;
  };
  ALTER TYPE default::Album {
      CREATE MULTI LINK discs: default::Disc;
      CREATE PROPERTY disc_total := (std::count(.discs));
  };
  CREATE TYPE default::Series {
      CREATE LINK label: default::Label;
      CREATE PROPERTY name: std::str;
  };
  ALTER TYPE default::Album {
      CREATE LINK series: default::Series;
  };
  ALTER TYPE default::Person {
      CREATE MULTI LINK groups := (.<members[IS default::Artist]);
  };
  CREATE SCALAR TYPE default::Mode EXTENDING enum<major, minor>;
  CREATE TYPE default::Key {
      CREATE LINK root: default::Note;
      CREATE PROPERTY mode: default::Mode;
      CREATE CONSTRAINT std::exclusive ON ((.root, .mode));
  };
  CREATE SCALAR TYPE default::Denominator EXTENDING enum<`1`, `2`, `4`, `8`, `16`, `32`, `64`>;
  CREATE TYPE default::TimeSignature {
      CREATE PROPERTY denominator: default::Denominator;
      CREATE PROPERTY numerator: std::int16;
      CREATE CONSTRAINT std::exclusive ON ((.numerator, .denominator));
  };
  CREATE TYPE default::Composition {
      CREATE MULTI LINK arrangers: default::Person;
      CREATE MULTI LINK composers: default::Person;
      CREATE LINK date_arranged: default::Date;
      CREATE LINK date_composed: default::Date;
      CREATE LINK key: default::Key;
      CREATE MULTI LINK lyricists: default::Person;
      CREATE LINK time_signature: default::TimeSignature;
      CREATE PROPERTY title: std::str;
  };
  ALTER TYPE default::Person {
      CREATE MULTI LINK arrangements := (.<arrangers[IS default::Composition]);
      CREATE PROPERTY is_arranger := ((std::count(.arrangements) > 0));
      CREATE MULTI LINK compositions := (.<composers[IS default::Composition]);
      CREATE PROPERTY is_composer := ((std::count(.compositions) > 0));
      CREATE MULTI LINK lyrics := (.<lyricists[IS default::Composition]);
      CREATE PROPERTY is_lyricist := ((std::count(.lyrics) > 0));
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK arrangements := (.<date_arranged[IS default::Composition]);
      CREATE MULTI LINK compositions := (.<date_composed[IS default::Composition]);
      CREATE MULTI LINK births := (.<birth_date[IS default::Person]);
      CREATE MULTI LINK deaths := (.<death_date[IS default::Person]);
  };
  CREATE TYPE default::Instrument {
      CREATE LINK tuning: default::Note;
      CREATE PROPERTY name: std::str;
      CREATE CONSTRAINT std::exclusive ON ((.name, .tuning));
      CREATE MULTI PROPERTY aliases: std::str;
  };
  ALTER TYPE default::Composition {
      CREATE MULTI LINK instrumentation: default::Instrument;
  };
  CREATE TYPE default::Player {
      CREATE LINK instrument: default::Instrument {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE LINK person: default::Person {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE CONSTRAINT std::exclusive ON ((.person, .instrument));
  };
  CREATE TYPE default::Track {
      CREATE MULTI LINK compositions: default::Composition;
      CREATE PROPERTY title: std::str {
          CREATE REWRITE
              INSERT 
              USING ((__subject__.title ?? std::to_str(std::array_agg((WITH
                  track := 
                      (SELECT
                          default::Track 
                      LIMIT
                          1
                      )
              SELECT
                  default::Composition.title
              FILTER
                  std::contains(std::array_agg(track.compositions), default::Composition)
              )), ',')));
          CREATE REWRITE
              UPDATE 
              USING ((__subject__.title ?? std::to_str(std::array_agg((WITH
                  track := 
                      (SELECT
                          default::Track 
                      LIMIT
                          1
                      )
              SELECT
                  default::Composition.title
              FILTER
                  std::contains(std::array_agg(track.compositions), default::Composition)
              )), ',')));
      };
      CREATE LINK date_mastered: default::Date;
      CREATE LINK date_mixed: default::Date;
      CREATE LINK date_recorded: default::Date;
      CREATE LINK date_released: default::Date;
      CREATE MULTI LINK players: default::Player;
      CREATE PROPERTY duration: std::duration;
      CREATE PROPERTY number: std::int16;
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK tracks_mastered := (.<date_mastered[IS default::Track]);
      CREATE MULTI LINK tracks_mixed := (.<date_mixed[IS default::Track]);
      CREATE MULTI LINK tracks_recorded := (.<date_recorded[IS default::Track]);
      CREATE MULTI LINK tracks_released := (.<date_released[IS default::Track]);
  };
  ALTER TYPE default::Disc {
      CREATE MULTI LINK tracks: default::Track;
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
          (.players.person.id = id)
      );
      CREATE MULTI LINK tracks := (WITH
          id := 
              .id
      SELECT
          default::Track
      FILTER
          (.players.person.id = id)
      );
      CREATE PROPERTY is_player := ((std::count(.<person[IS default::Player]) > 0));
  };
  ALTER TYPE default::Label {
      CREATE MULTI LINK series := (.<label[IS default::Series]);
  };
};
