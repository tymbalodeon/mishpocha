CREATE MIGRATION m1ehbzr7oa4shipbu2sjajmzngs2vdzqgagvu42dpgnj7phdkl3smq
    ONTO m1qu53fqhflj236nwi5uvskwcjr4bzdntu46hhhfnynqjl5dc5n7nq
{
  ALTER FUNCTION default::sum_durations(durations: std::duration) USING (WITH
      seconds := 
          (FOR duration IN durations
          UNION 
              std::duration_get(duration, 'totalseconds'))
  SELECT
      std::to_duration(seconds := std::sum(seconds))
  );
};
