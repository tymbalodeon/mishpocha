CREATE MIGRATION m1evche65orntwcqdzypekogdllkgsohob4445v6w7gofxkstfetea
    ONTO m1tn5ipfsswdi72mqsighfmb2qisnhulbvejd3bsjdr3jetnauhk2a
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
                  (__subject__.name ?? std::to_str(std::array_agg(((SELECT
                      default::Artist FILTER
                          (.id = id)
                  LIMIT
                      1
                  )).members.full_name), ', '))
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
                  (__subject__.name ?? std::to_str(std::array_agg(((SELECT
                      default::Artist FILTER
                          (.id = id)
                  LIMIT
                      1
                  )).members.full_name), ', '))
              );
      };
  };
};
