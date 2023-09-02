export interface Date {
  id: string;
  day: number;
  month: number;
  year: number;
  display: string;
  births: Person[];
  deaths: Person[];
  artist_starts: Artist[];
  artist_ends: Artist[];
  compositions: Composition[];
  arrangements: Composition[];
  tracks_recorded: Track[];
  tracks_released: Track[];
  tracks_mastered: Track[];
  tracks_mixed: Track[];
  albums_released: Album[];
}

export interface Person {
  id: string;
  first_name: string;
  last_name: string;
  aliases: String[];
  birth_date: Date;
  death_date: Date;
  is_alive: boolean;
  full_name: string;
  age: number[];
  compositions: Composition[];
  arrangements: Composition[];
  lyrics: Composition[];
  tracks: Track[];
  is_composer: boolean;
  is_arranger: boolean;
  is_lyricist: boolean;
  is_player: boolean;
  is_producer: boolean;
  instruments: Instrument[];
  groups: Artist[];
}

enum NoteName {
  C,
  D,
  E,
  F,
  G,
  A,
  B,
}

enum Accidental {
  Flat,
  Natural,
  Sharp,
}

export interface Note {
  name: NoteName;
  accidental: Accidental;
}

export interface Instrument {
  id: string;
  name: string;
  aliases: String[];
  tuning: Note;
  players: Player[];
}

enum Mode {
  Major,
  Minor,
}

export interface Key {
  root: Note;
  mode: Mode;
}

enum Denominator {
  One,
  Two,
  Four,
  Eight,
  Sixteen,
  ThirtyTwo,
  SixtyFour,
}

export interface TimeSignature {
  numerator: number;
  denominator: Denominator;
}

export interface Composition {
  id: string;
  title: string;
  composers: Person[];
  lyricists: Person[];
  arrangers: Person[];
  date_composed: Date;
  date_arranged: Date;
  instrumentation: Instrument[];
  key: Key;
  time_signature: TimeSignature;
}

export interface Player {
  id: string;
  person: Person;
  instrument: Instrument;
  display: string;
}

export interface Artist {
  id: string;
  name: string;
  members: Person[];
  date_start: Date;
  date_end: Date;
  albums: Album[];
}

export interface Track {
  id: string;
  title: string;
  compositions: Composition[];
  players: Player[];
  date_recorded: Date;
  date_released: Date;
  date_mastered: Date;
  date_mixed: Date;
  number: number;
  duration: string;
}

export interface Series {
  id: string;
  name: string;
  label: Label[];
  albums: Album[];
}

export interface Label {
  id: string;
  name: string;
  series: Series[];
  albums: Album[];
  artists: Artist[];
}

export interface Disc {
  id: string;
  disc_title: String[];
  number: number;
  tracks: Track[];
  album: Album;
  title: String[];
  duration: string;
}

export interface Album {
  id: string;
  title: string;
  artists: Artist[];
  producers: Person[];
  discs: Disc[];
  label: Label;
  catalog_number: number;
  series: Series;
  series_number: number;
  date_released: Date;
  date_recorded: Date;
  tracks: Track[];
  disc_total: number;
  duration: string;
}
