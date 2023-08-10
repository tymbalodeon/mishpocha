CREATE MIGRATION m1j4wakaw3z5bhgocyikkfdys2cxxr4dzflqcw6wdiy57m6r6mawoa
    ONTO m1dkfddrlkda44lehsuqpp7rfaq7ouodrx4lktlozidnfc57zw5gba
{
  ALTER TYPE default::Person {
      ALTER PROPERTY age {
          USING (WITH
              current_date := 
                  default::get_year(cal::to_local_date(std::datetime_of_statement(), 'UTC'))
              ,
              latest_date := 
                  (.death_date.year ?? current_date)
          SELECT
              (latest_date - .birth_date.year)
          );
      };
  };
};
