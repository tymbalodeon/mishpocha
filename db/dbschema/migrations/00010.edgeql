CREATE MIGRATION m1pq5zo66x7gqlxctn5m7siwlaicrwqgbf6rjt3nmgafm7rpfrn6ia
    ONTO m163nyew3t5co4qn2yjfcx4lj7szjljk6vsxum4yufoh3sgpxnjhba
{
  ALTER TYPE default::Date {
      CREATE CONSTRAINT std::exclusive ON ((.day, .month, .year));
  };
};
