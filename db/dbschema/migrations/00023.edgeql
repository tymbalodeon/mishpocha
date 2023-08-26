CREATE MIGRATION m1ed4wol7wxoopt5to7crkuzeqtyuzqn7mn2fwbh4u4fmwcbuyvy2q
    ONTO m1o547q4dnpzncqeioxxbsbjkgmpno3zfxk3aj5gsz3ftu4uukzrma
{
  ALTER TYPE default::Disc {
      ALTER PROPERTY duration {
          USING (std::to_duration(seconds := std::sum(std::duration_get(.tracks.duration, 'totalseconds'))));
      };
  };
  ALTER TYPE default::Album {
      ALTER PROPERTY duration {
          USING (std::to_duration(seconds := std::sum(std::duration_get(.discs.duration, 'totalseconds'))));
      };
  };
  DROP FUNCTION default::get_duration_from_seconds(seconds: std::float64);
  DROP FUNCTION default::get_totalseconds(duration: std::duration);
};
