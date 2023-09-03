CREATE MIGRATION m1ytlpidm4btnokdhbes2ziprl7bywwqdy2eurdfai5edpafa2sriq
    ONTO m167dcf4iqm5ocqnhdkeffccygl2mt2ngkeii6k645y6zasithi6qa
{
  ALTER TYPE default::Player {
      ALTER PROPERTY display {
          USING ((((.person.display ++ ' (') ++ .instrument.display) ++ ')'));
      };
  };
};
