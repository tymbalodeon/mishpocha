CREATE MIGRATION m12x7nk55nexwofas3fhekonylbwxfgnzojimacof2o7emcg7vvvba
    ONTO m1fx7jk7dl4yjakhjjrubtbm53sx5762ai6kxmd5dbmh5jf3otfihq
{
  ALTER TYPE default::Date {
      CREATE MULTI LINK deathdays := (.<death_date[IS default::Person]);
  };
};
