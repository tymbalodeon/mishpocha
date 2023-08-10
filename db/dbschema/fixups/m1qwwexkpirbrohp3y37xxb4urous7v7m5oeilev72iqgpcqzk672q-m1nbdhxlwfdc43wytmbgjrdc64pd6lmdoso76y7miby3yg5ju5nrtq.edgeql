CREATE MIGRATION m1qxisxzuyhzjz6vir2bjgwnfhyzqjykrfqtkw7jefv3jez54ejxjq
    ONTO m1qwwexkpirbrohp3y37xxb4urous7v7m5oeilev72iqgpcqzk672q
{
  ALTER TYPE default::Composition {
      DROP PROPERTY composition_date;
  };
  ALTER TYPE default::Composition {
      CREATE LINK composition_date: default::Date;
  };
};
