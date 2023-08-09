CREATE MIGRATION m1ldslw2t2zmevzb3nnymiqwbmkpqdp46q6fdgoalzv55zcac5gica
    ONTO m1laqdjo7anc3ruhdaxsvknyd73puptmvvur4rcap75lqwoo7htdpq
{
  ALTER TYPE default::Date {
      ALTER PROPERTY display {
          USING ({((((<std::str>.year ++ '-') ++ <std::str>.month) ++ '-') ++ <std::str>.day)});
      };
  };
};
