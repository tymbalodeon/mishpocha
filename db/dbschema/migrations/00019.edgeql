CREATE MIGRATION m1whlnxmyg54pcbxtxys5alnoyi2wwa5yrg24lnllswxt4nywoluya
    ONTO m1ehbzr7oa4shipbu2sjajmzngs2vdzqgagvu42dpgnj7phdkl3smq
{
  CREATE FUNCTION default::get_totalseconds(duration: std::duration) ->  std::float64 USING (std::duration_get(duration, 'totalseconds'));
  ALTER TYPE default::Disc {
      ALTER PROPERTY duration {
          USING (std::to_duration(seconds := std::sum(std::duration_get(.tracks.duration, 'totalseconds'))));
      };
  };
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (default::get_totalseconds(.discs.duration));
      };
  };
  DROP FUNCTION default::sum_durations(durations: std::duration);
};
