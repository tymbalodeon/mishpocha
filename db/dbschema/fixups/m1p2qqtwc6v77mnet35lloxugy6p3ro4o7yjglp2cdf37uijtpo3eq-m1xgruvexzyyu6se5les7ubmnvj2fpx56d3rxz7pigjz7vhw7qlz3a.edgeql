CREATE MIGRATION m1abovkagfevl3gzkjtk5xxzd4qnboakt2lgfndefxxsbllyu7pxxa
    ONTO m1p2qqtwc6v77mnet35lloxugy6p3ro4o7yjglp2cdf37uijtpo3eq
{
  ALTER TYPE default::Artist {
      CREATE MULTI LINK albums := (.<artists[IS default::Album]);
  };
  ALTER TYPE default::Instrument {
      CREATE CONSTRAINT std::exclusive ON ((.name, .tuning));
  };
  ALTER TYPE default::Key {
      CREATE CONSTRAINT std::exclusive ON ((.root, .mode));
  };
  ALTER TYPE default::Note {
      CREATE CONSTRAINT std::exclusive ON ((.name, .accidental));
  };
  ALTER TYPE default::Player {
      CREATE CONSTRAINT std::exclusive ON ((.person, .instrument));
  };
  ALTER TYPE default::TimeSignature {
      CREATE CONSTRAINT std::exclusive ON ((.numerator, .denominator));
  };
};
