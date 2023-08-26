CREATE MIGRATION m1ot3aqdnw25i5g7ixyp3iqjafvoqwahizny2blmya5yl7ijzvysta
    ONTO m14lfew7etvwhhlil3kspnijjydn742re7igpav3vnvpuocstli6eq
{
  CREATE FUNCTION default::get_totalseconds(duration: std::duration) ->  std::float64 USING (std::duration_get(duration, 'totalseconds'));
  ALTER TYPE default::Disc {
      ALTER PROPERTY duration {
          USING (std::to_duration(seconds := std::sum(default::get_totalseconds(.tracks.duration))));
      };
  };
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (std::to_duration(seconds := std::sum(default::get_totalseconds(.discs.duration))));
      };
  };
  DROP FUNCTION default::sum_duration(durations: std::duration);
};
