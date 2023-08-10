CREATE MIGRATION m1vnclqdbnoztihwrigngrxb4atykbyuec4v5wm6oc7252efwidb7a
    ONTO m1af5ir6evyjrosc6rylkjvyj2uxye2siiuiecc2xecd7ow3nngbsq
{
  ALTER TYPE default::Album {
      ALTER LINK artist {
          RENAME TO artists;
      };
  };
  CREATE TYPE default::Disc {
      CREATE MULTI LINK tracks: default::Track;
      CREATE PROPERTY number: std::int16 {
          CREATE CONSTRAINT std::min_value(1);
      };
      CREATE PROPERTY title: std::str;
  };
  ALTER TYPE default::Album {
      CREATE MULTI LINK discs: default::Disc;
  };
  ALTER TYPE default::Album {
      CREATE PROPERTY disc_total := (std::count(.discs));
  };
  ALTER TYPE default::Album {
      DROP LINK tracks;
  };
  ALTER TYPE default::Composition {
      ALTER LINK arranger {
          RENAME TO arrangers;
      };
  };
  ALTER TYPE default::Composition {
      ALTER LINK composer {
          RENAME TO composers;
      };
  };
  ALTER TYPE default::Composition {
      ALTER LINK lyricist {
          RENAME TO lyricists;
      };
  };
};
