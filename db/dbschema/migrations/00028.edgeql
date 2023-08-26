CREATE MIGRATION m1uj2vxosht2mnmav5rp2zihf3hxnhlakni4z2xpcgjzh65v6cbpya
    ONTO m1vk362mz6wrijcmgcsjaj5o6x7mhgv3qbr2qxp4aid6dwkwrei4xq
{
  ALTER TYPE default::Album {
      CREATE PROPERTY catalog_number: std::int64;
      ALTER PROPERTY series_number {
          SET TYPE std::int64;
      };
  };
};
