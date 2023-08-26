CREATE MIGRATION m1bsvwudivgttaqhh3tl2bbmtqglzk7n2jexfliprontrh6a54oftq
    ONTO m1jjl5lb4cawfbv3pz5sthkykzk57fjtetrlmdgtxzscm66q4bnoaq
{
  CREATE FUNCTION default::sum_durations(durations: std::duration) ->  std::duration USING (std::to_duration(seconds := std::sum(std::duration_get(durations, 'totalseconds'))));
};
