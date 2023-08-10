CREATE MIGRATION m1kki3cnqasypbdbpf2e5yosybquwwqyfw2cbpulbfh4wnkcer2yda
    ONTO m1nbdhxlwfdc43wytmbgjrdc64pd6lmdoso76y7miby3yg5ju5nrtq
{
  ALTER TYPE default::Track {
      ALTER PROPERTY title {
          CREATE REWRITE
              INSERT 
              USING ((__subject__.title ?? std::to_str(std::array_agg((WITH
                  track := 
                      (SELECT
                          default::Track 
                      LIMIT
                          1
                      )
              SELECT
                  default::Composition.title
              FILTER
                  std::contains(std::array_agg(track.compositions), default::Composition)
              )), ',')));
          CREATE REWRITE
              UPDATE 
              USING ((__subject__.title ?? std::to_str(std::array_agg((WITH
                  track := 
                      (SELECT
                          default::Track 
                      LIMIT
                          1
                      )
              SELECT
                  default::Composition.title
              FILTER
                  std::contains(std::array_agg(track.compositions), default::Composition)
              )), ',')));
      };
  };
};
