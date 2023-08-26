CREATE MIGRATION m1u5szl6osiafhojctrpbcntjo7nufvw4siw4wqk7vkffeqwcy567a
    ONTO m1h4hpmgl2pkjbtb3yeslyqv4ojb7sthjr73c3a4ynkjdp4bsr3h3a
{
  ALTER TYPE default::Track {
      ALTER PROPERTY title {
          DROP REWRITE
              INSERT ;
          };
      };
  ALTER TYPE default::Track {
      ALTER PROPERTY title {
          CREATE REWRITE
              INSERT 
              USING (WITH
                  id := 
                      .id
              SELECT
                  (__subject__.title ?? (WITH
                      compositions := 
                          (__subject__.compositions ?? (SELECT
                              default::Track.compositions FILTER
                                  (.id = id)
                          LIMIT
                              1
                          ))
                  SELECT
                      std::to_str(std::array_agg(compositions.title), ', ')
                  ))
              );
      };
  };
  ALTER TYPE default::Track {
      ALTER PROPERTY title {
          DROP REWRITE
              UPDATE ;
          };
      };
  ALTER TYPE default::Track {
      ALTER PROPERTY title {
          CREATE REWRITE
              UPDATE 
              USING (WITH
                  id := 
                      .id
              SELECT
                  (__subject__.title ?? (WITH
                      compositions := 
                          (__subject__.compositions ?? (SELECT
                              default::Track.compositions FILTER
                                  (.id = id)
                          LIMIT
                              1
                          ))
                  SELECT
                      std::to_str(std::array_agg(compositions.title), ', ')
                  ))
              );
      };
  };
};
