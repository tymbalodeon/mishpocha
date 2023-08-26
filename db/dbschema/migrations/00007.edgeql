CREATE MIGRATION m1ca6bk43oxivgwm3agd24qcgur3vniz7yamwwowekeiyn7cmywbgq
    ONTO m1wzmpurqthhgaghg45g2fr57e5aiif7mpbt4pyxckoyetdcmmvmnq
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
                      std::to_str(std::array_agg(members.full_name), ', ')
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
                      std::to_str(std::array_agg(members.full_name), ', ')
                  ))
              );
      };
  };
};
