CREATE MIGRATION m1n2t4fetuigl7xmkifh3oodvvojsgdom3g4axcrrt5coxygdmi3jq
    ONTO m1hshweiceooltl263mb5jwalgcznetx32fnsuutxudm7mb3inzrdq
{
  ALTER TYPE default::Person {
      ALTER LINK instruments {
          USING (WITH
              id := 
                  .id
          SELECT
              default::Instrument
          FILTER
              (.players.person.id = id)
          );
      };
  };
};
