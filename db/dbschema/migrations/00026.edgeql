CREATE MIGRATION m1xyfpw556yvocpba6lbztxprr5d5qcnbf5i4qw4fuddgyaekyrx7q
    ONTO m1ot3aqdnw25i5g7ixyp3iqjafvoqwahizny2blmya5yl7ijzvysta
{
  CREATE FUNCTION default::get_duration_from_seconds(seconds: std::float64) ->  std::duration USING (std::to_duration(seconds := seconds));
  ALTER TYPE default::Disc {
      ALTER PROPERTY duration {
          USING (WITH
              seconds := 
                  std::sum(default::get_totalseconds(.tracks.duration))
          SELECT
              default::get_duration_from_seconds(seconds)
          );
      };
  };
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (WITH
              seconds := 
                  std::sum(default::get_totalseconds(.discs.duration))
          SELECT
              default::get_duration_from_seconds(seconds)
          );
      };
  };
};
