CREATE MIGRATION m12hup7ntdr5bu5nzlgtzv76k6wdapajdmv5kavy5khgijqjsvo7sa
    ONTO m1gdxyee6u2qy5u5mwgkr3as75xpu73nxeol4z7tc3l66ag22znpqq
{
  ALTER FUNCTION default::get_age_when(person: default::Person, date: default::Date) USING (WITH
      age := 
          (date.year - person.birth_date.year)
  SELECT
      (<std::float64>age IF ((date.month >= person.birth_date.month) AND (date.day >= person.birth_date.day)) ELSE <std::float64>(age - 1))
  );
};
