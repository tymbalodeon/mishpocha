CREATE MIGRATION m1kggmf4nspk47sretu4g25mfj7ioz7zcvwxzneykwbakofq6fw6qa
    ONTO m12hup7ntdr5bu5nzlgtzv76k6wdapajdmv5kavy5khgijqjsvo7sa
{
  ALTER FUNCTION default::get_age_when(person: default::Person, date: default::Date) USING (WITH
      age := 
          (date.year - person.birth_date.year)
  SELECT
      (age IF ((date.month >= person.birth_date.month) AND (date.day >= person.birth_date.day)) ELSE (age - 1))
  );
};
