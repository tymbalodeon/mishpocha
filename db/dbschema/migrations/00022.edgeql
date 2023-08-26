CREATE MIGRATION m1o547q4dnpzncqeioxxbsbjkgmpno3zfxk3aj5gsz3ftu4uukzrma
    ONTO m12m6ezvo3agi7u42gqkfudt66ar3xdi73llpw55mov7pqefowzbza
{
  ALTER TYPE default::Disc {
      ALTER PROPERTY duration {
          USING (default::get_duration_from_seconds(default::get_totalseconds(.tracks.duration)));
      };
  };
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (default::get_duration_from_seconds(default::get_totalseconds(.discs.duration)));
      };
  };
};
