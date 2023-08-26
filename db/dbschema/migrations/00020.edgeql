CREATE MIGRATION m1btlzqm6wsie7faskijca2wglkpbvwvc2lvhmiqdev3x3q2rgfyhq
    ONTO m1whlnxmyg54pcbxtxys5alnoyi2wwa5yrg24lnllswxt4nywoluya
{
  CREATE FUNCTION default::get_duration_from_seconds(seconds: std::float64) ->  std::duration USING (std::to_duration(seconds := std::sum(seconds)));
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (default::get_duration_from_seconds(default::get_totalseconds(.discs.duration)));
      };
  };
};
