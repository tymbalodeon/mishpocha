CREATE MIGRATION m14lfew7etvwhhlil3kspnijjydn742re7igpav3vnvpuocstli6eq
    ONTO m1ed4wol7wxoopt5to7crkuzeqtyuzqn7mn2fwbh4u4fmwcbuyvy2q
{
  CREATE FUNCTION default::sum_duration(durations: std::duration) ->  std::duration USING (std::to_duration(seconds := std::sum(std::duration_get(durations, 'totalseconds'))));
};
