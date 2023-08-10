CREATE MIGRATION m1arp37x2b25a77gdxc237shzq3bkghj7677wp7txcpvsdwl3th2vq
    ONTO m1j4wakaw3z5bhgocyikkfdys2cxxr4dzflqcw6wdiy57m6r6mawoa
{
  ALTER TYPE default::Person {
      ALTER PROPERTY age {
          USING (WITH
              current_date := 
                  default::get_year(cal::to_local_date(std::datetime_of_statement(), 'UTC'))
              ,
              latest_date := 
                  (.death_date.year ?? current_date)
              ,
              year := 
                  (latest_date - .birth_date.year)
          SELECT
              (year IF ((.death_date.month >= .birth_date.month) AND (.death_date.day >= .birth_date.day)) ELSE (year - 1))
          );
      };
  };
};
