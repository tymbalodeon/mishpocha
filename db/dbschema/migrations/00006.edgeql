CREATE MIGRATION m1dkfddrlkda44lehsuqpp7rfaq7ouodrx4lktlozidnfc57zw5gba
    ONTO m1q2nh6rnwyj2ctd35h65pbxbgxc46y4iwexxy4yqevyq4ricvbl7q
{
  ALTER TYPE default::Person {
      CREATE PROPERTY age := (WITH
          latest_date := 
              (.death_date.local_date ?? cal::to_local_date(std::datetime_of_statement(), 'UTC'))
      SELECT
          (default::get_year(latest_date) - default::get_year(.birth_date.local_date))
      );
  };
};
