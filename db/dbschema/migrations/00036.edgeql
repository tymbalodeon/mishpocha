CREATE MIGRATION m1qf2xebeml2wnn2evpdtvskhh645sjdwujh3prjsfehyjw2hf6bra
    ONTO m1ytlpidm4btnokdhbes2ziprl7bywwqdy2eurdfai5edpafa2sriq
{
  ALTER TYPE default::Instrument {
      ALTER PROPERTY display {
          USING (WITH
              tuning := 
                  .tuning.display
              ,
              name := 
                  (SELECT
                      (((tuning ++ ' ') IF EXISTS (tuning) ELSE '') ++ .name)
                  )
          SELECT
              std::str_title(name)
          );
      };
  };
};
