CREATE MIGRATION m1vk362mz6wrijcmgcsjaj5o6x7mhgv3qbr2qxp4aid6dwkwrei4xq
    ONTO m1xyfpw556yvocpba6lbztxprr5d5qcnbf5i4qw4fuddgyaekyrx7q
{
  ALTER TYPE default::Disc {
      ALTER PROPERTY title {
          USING ((.disc_title ?? .album.title));
      };
  };
};
