export interface Date {
  id: string;
  type_name: string;
  display: string;
  day: number;
  month: number;
  year: number;
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
  type_name: string;
  display: string;
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
  artists: Artist[];
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
  id: string;
  type_name: string;
  display: string;
  name: NoteName;
  accidental: Accidental;
}

export interface Instrument {
  id: string;
  type_name: string;
  display: string;
  name: string;
  aliases: string[];
  tuning: Note;
  players: Player[];
  player_names: string[];
}

enum Mode {
  Major,
  Minor,
}

export interface Key {
  id: string;
  type_name: string;
  display: string;
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
  id: string;
  type_name: string;
  display: string;
  numerator: number;
  denominator: Denominator;
}

export interface Composition {
  id: string;
  type_name: string;
  display: string;
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
  type_name: string;
  display: string;
  person: Person;
  instrument: Instrument;
  display: string;
}

export interface Artist {
  id: string;
  type_name: string;
  display: string;
  name: string;
  members: Person[];
  date_start: Date;
  date_end: Date;
  albums: Album[];
}

export interface Track {
  id: string;
  type_name: string;
  display: string;
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
  type_name: string;
  display: string;
  name: string;
  label: Label[];
  albums: Album[];
}

export interface Label {
  id: string;
  type_name: string;
  display: string;
  name: string;
  series: Series[];
  albums: Album[];
  artists: Artist[];
}

export interface Disc {
  id: string;
  type_name: string;
  display: string;
  disc_title: String[];
  number: number;
  tracks: Track[];
  album: Album;
  title: String[];
  duration: string;
}

export interface Album {
  id: string;
  type_name: string;
  display: string;
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

export type DatabaseProps =
  | Date
  | Person
  | Instrument
  | Composition
  | Artist
  | Album
  | Track
  | Label
  | Series;
