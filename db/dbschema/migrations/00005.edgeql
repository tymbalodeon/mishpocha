CREATE MIGRATION m1q2nh6rnwyj2ctd35h65pbxbgxc46y4iwexxy4yqevyq4ricvbl7q
    ONTO m1k3ericaxazbpu57kz7cyziw3glqljjygg3zljzes2kz2whs6swxa
{
  ALTER TYPE default::Date {
      ALTER PROPERTY local_date {
          USING ({cal::to_local_date(.year, .month, .day)});
      };
  };
};
