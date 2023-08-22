CREATE MIGRATION m1ds76hxz7mmcwc447vmddtwafti4lzsrzosfkykyv6vupk6bf4sjq
    ONTO m1vgyzqhthsvapvewsl4s46hbzev5ubgdfvnvsbibi7ippoyo7aeza
{
  ALTER TYPE default::Player {
      ALTER LINK instrument {
          ON TARGET DELETE DELETE SOURCE;
      };
      ALTER LINK person {
          ON TARGET DELETE DELETE SOURCE;
      };
  };
};
