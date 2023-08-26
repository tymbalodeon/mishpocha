CREATE MIGRATION m1tn5ipfsswdi72mqsighfmb2qisnhulbvejd3bsjdr3jetnauhk2a
    ONTO m1grwhmcjdhrlbhijigx7yy6n4anfinel6ylb4v6hvydx4xnztv5uq
{
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
                  )).members.full_name), ','))
              );
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
                  )).members.full_name), ','))
              );
      };
  };
};
