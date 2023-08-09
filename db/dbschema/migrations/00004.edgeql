CREATE MIGRATION m1k3ericaxazbpu57kz7cyziw3glqljjygg3zljzes2kz2whs6swxa
    ONTO m1lhmjetkrc6nrupt6pquzixhmda2tpgaonoklpzv4c7d5a7blsbva
{
  ALTER TYPE default::Date {
      CREATE PROPERTY local_date := ({<cal::local_date>.display});
  };
};
