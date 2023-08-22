CREATE MIGRATION m1bo5xgpvsrudy272a6h2wckgsrh25t5hicxdxg2h2mj5jiexphihq
    ONTO m1g6jfn45hye3ml6oq7ge53fbchbjazl4wvyppvii3nozcnvowu2ba
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
};
