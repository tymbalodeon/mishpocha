CREATE MIGRATION m1fx7jk7dl4yjakhjjrubtbm53sx5762ai6kxmd5dbmh5jf3otfihq
    ONTO m1pq5zo66x7gqlxctn5m7siwlaicrwqgbf6rjt3nmgafm7rpfrn6ia
{
  ALTER TYPE default::Date {
      CREATE MULTI LINK birthdays := (.<birth_date[IS default::Person]);
  };
};
