CREATE MIGRATION m132nc7bxyyycavfbl25nt2go3ygmcrs3hyu3c473extuzty3s3mjq
    ONTO m1o4cj5adpi3lde5h6fawqdare5xqxxsi6ntg6wzbfqoeuymrpiwgq
{
  ALTER TYPE default::Album {
      CREATE LINK date_released: default::Date;
      CREATE PROPERTY series_number: std::int32;
  };
  ALTER TYPE default::Disc {
      ALTER PROPERTY number {
          SET TYPE std::int32;
      };
  };
};
