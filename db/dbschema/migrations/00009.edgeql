CREATE MIGRATION m163nyew3t5co4qn2yjfcx4lj7szjljk6vsxum4yufoh3sgpxnjhba
    ONTO m1arp37x2b25a77gdxc237shzq3bkghj7677wp7txcpvsdwl3th2vq
{
  CREATE FUNCTION default::get_date_element(local_date: cal::local_date, element: std::str) ->  std::float64 USING (cal::date_get(local_date, element));
  ALTER TYPE default::Person {
      ALTER PROPERTY age {
          USING (WITH
              current_date := 
                  cal::to_local_date(std::datetime_of_statement(), 'UTC')
              ,
              current_year := 
                  default::get_date_element(current_date, 'year')
              ,
              current_month := 
                  default::get_date_element(current_date, 'month')
              ,
              current_day := 
                  default::get_date_element(current_date, 'day')
              ,
              latest_year := 
                  (.death_date.year ?? current_year)
              ,
              latest_month := 
                  (.death_date.month ?? current_month)
              ,
              latest_day := 
                  (.death_date.day ?? current_day)
              ,
              age := 
                  (latest_year - .birth_date.year)
          SELECT
              (age IF ((latest_month >= .birth_date.month) AND (latest_day >= .birth_date.day)) ELSE (age - 1))
          );
      };
  };
  DROP FUNCTION default::get_year(local_date: cal::local_date);
};
