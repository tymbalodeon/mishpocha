CREATE MIGRATION m12m6ezvo3agi7u42gqkfudt66ar3xdi73llpw55mov7pqefowzbza
    ONTO m1btlzqm6wsie7faskijca2wglkpbvwvc2lvhmiqdev3x3q2rgfyhq
{
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (default::get_duration_from_seconds(default::get_totalseconds({.discs.duration})));
      };
  };
};
