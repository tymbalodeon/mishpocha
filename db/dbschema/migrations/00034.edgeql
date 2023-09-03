CREATE MIGRATION m167dcf4iqm5ocqnhdkeffccygl2mt2ngkeii6k645y6zasithi6qa
    ONTO m1qprq6fmjufzjomdp776aduuda7d3pllayxmpqurjfi7uzfuslwmq
{
  ALTER TYPE default::Album {
      CREATE PROPERTY display := (.title);
  };
  ALTER TYPE default::Artist {
      CREATE PROPERTY display := (.name);
  };
  ALTER TYPE default::Composition {
      CREATE PROPERTY display := (.title);
  };
  ALTER TYPE default::Disc {
      CREATE PROPERTY display := (.title);
  };
  ALTER TYPE default::Note {
      CREATE PROPERTY display := (((<std::str>.name ++ ' ') ++ <std::str>.accidental));
  };
  ALTER TYPE default::Instrument {
      CREATE PROPERTY display := (WITH
          tuning := 
              .tuning.display
      SELECT
          (((tuning ++ ' ') IF EXISTS (tuning) ELSE '') ++ .name)
      );
  };
  ALTER TYPE default::Key {
      CREATE PROPERTY display := (((.root.display ++ ' ') ++ <std::str>.mode));
  };
  ALTER TYPE default::Label {
      CREATE PROPERTY display := (.name);
  };
  ALTER TYPE default::Person {
      CREATE PROPERTY display := (.full_name);
  };
  ALTER TYPE default::Series {
      CREATE PROPERTY display := (.name);
  };
  ALTER TYPE default::TimeSignature {
      CREATE PROPERTY display := (((<std::str>.numerator ++ '/') ++ <std::str>.denominator));
  };
  ALTER TYPE default::Track {
      CREATE PROPERTY display := (.title);
  };
};
