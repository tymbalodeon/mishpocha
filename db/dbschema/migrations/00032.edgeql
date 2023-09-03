CREATE MIGRATION m1w3alaxyxkmvbi6ax7zope4c56yygerh2jalfwp6pffvbpuggah6a
    ONTO m16ajm5c3xpwo46p6j7qptxtvr72trd6pwyr7cf2mnumeeondexpiq
{
  ALTER TYPE default::Album {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'album';
      };
  };
  ALTER TYPE default::Artist {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'artist';
      };
  };
  ALTER TYPE default::Composition {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'composition';
      };
  };
  ALTER TYPE default::Disc {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'disc';
      };
  };
  ALTER TYPE default::Instrument {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'instrument';
      };
  };
  ALTER TYPE default::Key {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'key';
      };
  };
  ALTER TYPE default::Label {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'label';
      };
  };
  ALTER TYPE default::Note {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'note';
      };
  };
  ALTER TYPE default::Person {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'person';
      };
  };
  ALTER TYPE default::Player {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'player';
      };
  };
  ALTER TYPE default::Series {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'series';
      };
  };
  ALTER TYPE default::TimeSignature {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'time_signature';
      };
  };
  ALTER TYPE default::Track {
      CREATE PROPERTY type_name: std::str {
          EXTENDING default::type_name;
          SET default := 'track';
      };
  };
};
