CREATE MIGRATION m15injsvyu36nwno2giar7cg5hj6jqgkdx7ms6nyyradzav3u5usxq
    ONTO m1zomvq76prt6jeiq45vypuza57w6yokbcwiyj3kyohl5bq27zigia
{
  ALTER TYPE default::Composition {
      ALTER LINK arrangement_date {
          RENAME TO date_arranged;
      };
  };
  ALTER TYPE default::Composition {
      ALTER LINK composition_date {
          RENAME TO date_composed;
      };
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK albums_released := (.<date_released[IS default::Album]);
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK arrangements := (.<date_arranged[IS default::Composition]);
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK artist_ends := (.<date_end[IS default::Artist]);
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK artist_starts := (.<date_start[IS default::Artist]);
  };
  ALTER TYPE default::Date {
      ALTER LINK birthdays {
          RENAME TO births;
      };
  };
  ALTER TYPE default::Date {
      ALTER LINK deathdays {
          RENAME TO deaths;
      };
  };
  ALTER TYPE default::Date {
      CREATE MULTI LINK tracks_mastered := (.<date_mastered[IS default::Track]);
      CREATE MULTI LINK tracks_mixed := (.<date_mixed[IS default::Track]);
      CREATE MULTI LINK tracks_recorded := (.<date_recorded[IS default::Track]);
      CREATE MULTI LINK tracks_released := (.<date_released[IS default::Track]);
  };
};
