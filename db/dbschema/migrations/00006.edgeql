CREATE MIGRATION m1wzmpurqthhgaghg45g2fr57e5aiif7mpbt4pyxckoyetdcmmvmnq
    ONTO m1evche65orntwcqdzypekogdllkgsohob4445v6w7gofxkstfetea
{
  ALTER TYPE default::Artist {
      ALTER PROPERTY name {
          DROP REWRITE
              INSERT ;
          };
      };
  ALTER TYPE default::Artist {
      ALTER PROPERTY name {
          CREATE REWRITE
              INSERT 
              USING (WITH
                  id := 
                      .id
              SELECT
                  (__subject__.name ?? (WITH
                      members := 
                          (__subject__.members ?? (SELECT
                              default::Artist.members FILTER
                                  (.id = id)
                          LIMIT
                              1
                          ))
                  SELECT
                      std::to_str(std::array_agg(((SELECT
                          default::Artist FILTER
                              (.id = id)
                      LIMIT
                          1
                      )).members.full_name), ', ')
                  ))
              );
      };
  };
  ALTER TYPE default::Artist {
      ALTER PROPERTY name {
          DROP REWRITE
              UPDATE ;
          };
      };
  ALTER TYPE default::Artist {
      ALTER PROPERTY name {
          CREATE REWRITE
              UPDATE 
              USING (WITH
                  id := 
                      .id
              SELECT
                  (__subject__.name ?? (WITH
                      members := 
                          (__subject__.members ?? (SELECT
                              default::Artist.members FILTER
                                  (.id = id)
                          LIMIT
                              1
                          ))
                  SELECT
                      std::to_str(std::array_agg(((SELECT
                          default::Artist FILTER
                              (.id = id)
                      LIMIT
                          1
                      )).members.full_name), ', ')
                  ))
              );
      };
  };
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
                  (__subject__.title ?? std::to_str(std::array_agg(((SELECT
                      default::Track FILTER
                          (.id = id)
                  LIMIT
                      1
                  )).compositions.title), ', '))
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
                  (__subject__.title ?? std::to_str(std::array_agg(((SELECT
                      default::Track FILTER
                          (.id = id)
                  LIMIT
                      1
                  )).compositions.title), ', '))
              );
      };
  };
};
