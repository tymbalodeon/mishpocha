CREATE MIGRATION m1grwhmcjdhrlbhijigx7yy6n4anfinel6ylb4v6hvydx4xnztv5uq
    ONTO m1q7e6w6nqzb2raxhriplqgd6yqe5aqtvswn4foplnmw2miojtjjxa
{
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
              default::get_age(.birth_date.year, .birth_date.month, .birth_date.day, latest_year, latest_month, latest_day)
          );
      };
  };
};
