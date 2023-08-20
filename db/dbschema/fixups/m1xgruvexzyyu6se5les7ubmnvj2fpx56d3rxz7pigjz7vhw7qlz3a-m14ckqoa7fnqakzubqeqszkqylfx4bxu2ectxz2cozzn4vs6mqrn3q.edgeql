CREATE MIGRATION m1spsli3njjoivnrkejmrqbmfkujwlxecvdym7q56uy3jtrmdwxnea
    ONTO m1xgruvexzyyu6se5les7ubmnvj2fpx56d3rxz7pigjz7vhw7qlz3a
{
  ALTER TYPE default::Artist {
      DROP PROPERTY year_end;
  };
  ALTER TYPE default::Artist {
      CREATE LINK year_end: default::Date;
  };
  ALTER TYPE default::Artist {
      DROP PROPERTY year_start;
  };
  ALTER TYPE default::Artist {
      CREATE LINK year_start: default::Date;
  };
  ALTER TYPE default::Composition {
      DROP PROPERTY arrangement_date;
  };
  ALTER TYPE default::Composition {
      CREATE LINK arrangement_date: default::Date;
  };
  ALTER TYPE default::Track {
      DROP PROPERTY year_mastered;
  };
  ALTER TYPE default::Track {
      CREATE LINK year_mastered: default::Date;
  };
  ALTER TYPE default::Track {
      DROP PROPERTY year_mixed;
  };
  ALTER TYPE default::Track {
      CREATE LINK year_mixed: default::Date;
  };
  ALTER TYPE default::Track {
      DROP PROPERTY year_recorded;
  };
  ALTER TYPE default::Track {
      CREATE LINK year_recorded: default::Date;
  };
  ALTER TYPE default::Track {
      DROP PROPERTY year_released;
  };
  ALTER TYPE default::Track {
      CREATE LINK year_released: default::Date;
  };
};
