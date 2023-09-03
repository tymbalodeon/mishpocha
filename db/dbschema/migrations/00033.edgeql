CREATE MIGRATION m1qprq6fmjufzjomdp776aduuda7d3pllayxmpqurjfi7uzfuslwmq
    ONTO m1w3alaxyxkmvbi6ax7zope4c56yygerh2jalfwp6pffvbpuggah6a
{
  ALTER TYPE default::Person {
      ALTER LINK groups {
          RENAME TO artists;
      };
  };
};
