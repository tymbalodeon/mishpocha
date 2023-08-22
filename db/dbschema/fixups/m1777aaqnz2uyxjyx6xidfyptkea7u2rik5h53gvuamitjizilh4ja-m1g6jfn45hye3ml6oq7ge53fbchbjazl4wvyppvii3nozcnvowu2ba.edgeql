CREATE MIGRATION m1reyiy3k33nk2hvtswpbk5g6v43hhozpfwgc6rm6zlu5x5odxhkdq
    ONTO m1777aaqnz2uyxjyx6xidfyptkea7u2rik5h53gvuamitjizilh4ja
{
  ALTER TYPE default::Artist {
      ALTER LINK year_end {
          RENAME TO date_end;
      };
  };
  ALTER TYPE default::Artist {
      ALTER LINK year_start {
          RENAME TO date_start;
      };
  };
  ALTER TYPE default::Track {
      ALTER LINK year_mastered {
          RENAME TO date_mastered;
      };
  };
  ALTER TYPE default::Track {
      ALTER LINK year_mixed {
          RENAME TO date_mixed;
      };
  };
  ALTER TYPE default::Track {
      ALTER LINK year_recorded {
          RENAME TO date_recorded;
      };
  };
  ALTER TYPE default::Track {
      ALTER LINK year_released {
          RENAME TO date_released;
      };
  };
};
