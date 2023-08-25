CREATE MIGRATION m17detel35e5pqbjq6xdtipgf3xphxgv57tustn5vtfnrbfiycejka
    ONTO m1kggmf4nspk47sretu4g25mfj7ioz7zcvwxzneykwbakofq6fw6qa
{
  CREATE FUNCTION default::get_age(person_year: std::float64, person_month: std::float64, person_day: std::float64, date_year: std::float64, date_month: std::float64, date_day: std::float64) -> SET OF std::float64 USING (WITH
      age := 
          (date_year - person_year)
  SELECT
      (age IF ((date_month >= person_month) AND (date_day >= person_day)) ELSE (age - 1))
  );
  ALTER FUNCTION default::get_age_when(person: default::Person, date: default::Date) USING (default::get_age(date.year, date.month, date.day, person.birth_date.year, person.birth_date.month, person.birth_date.day));
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
          SELECT
              default::get_age(latest_year, latest_month, latest_day, .birth_date.year, .birth_date.month, .birth_date.day)
          );
      };
  };
};
