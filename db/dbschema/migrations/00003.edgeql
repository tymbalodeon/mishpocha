CREATE MIGRATION m1lhmjetkrc6nrupt6pquzixhmda2tpgaonoklpzv4c7d5a7blsbva
    ONTO m1ldslw2t2zmevzb3nnymiqwbmkpqdp46q6fdgoalzv55zcac5gica
{
  ALTER TYPE default::Date {
      ALTER PROPERTY display {
          USING ({std::to_str([<std::str>.year, <std::str>.month, <std::str>.day], '-')});
      };
  };
};
