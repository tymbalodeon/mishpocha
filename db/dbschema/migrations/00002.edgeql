CREATE MIGRATION m1gdxyee6u2qy5u5mwgkr3as75xpu73nxeol4z7tc3l66ag22znpqq
    ONTO m1gdtcqmm7u5crofbqtmm3ltafzji4emvynubfmw3qpp6dih6bui3q
{
  CREATE FUNCTION default::get_age_when(person: default::Person, date: default::Date) -> SET OF std::float64 USING (WITH
      age := 
          (date.year - person.birth_date.year)
  SELECT
      (age IF ((date.month >= person.birth_date.month) AND (date.day >= person.birth_date.day)) ELSE (age - 1))
  );
};
