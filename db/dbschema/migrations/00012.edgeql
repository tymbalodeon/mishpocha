CREATE MIGRATION m1h4hpmgl2pkjbtb3yeslyqv4ojb7sthjr73c3a4ynkjdp4bsr3h3a
    ONTO m1cdyu6s2sqdsadow7u6pdwioctp3a7lqpzyarxpjtrr4c4rnqnc5a
{
  ALTER TYPE default::Disc {
      ALTER LINK album {
          USING (.<discs[IS default::Album]);
      };
  };
};
