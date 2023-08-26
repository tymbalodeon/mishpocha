CREATE MIGRATION m1qu53fqhflj236nwi5uvskwcjr4bzdntu46hhhfnynqjl5dc5n7nq
    ONTO m1bsvwudivgttaqhh3tl2bbmtqglzk7n2jexfliprontrh6a54oftq
{
  ALTER TYPE default::Disc {
      ALTER PROPERTY duration {
          USING (default::sum_durations(.tracks.duration));
      };
  };
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (default::sum_durations(.discs.duration));
      };
  };
};
