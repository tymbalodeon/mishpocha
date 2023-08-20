use edgedb_derive::Queryable;
use edgedb_protocol::model::{Duration, LocalDate};

#[derive(Debug, Queryable)]
pub struct Date {
    pub day: Option<i16>,
    pub month: Option<i16>,
    pub year: Option<Vec<i32>>,
    pub display: Option<String>,
    pub local_date: Option<LocalDate>,
    // pub birhtdays: Option<Vec<Person>>,
    // pub deathdays: Option<Vec<Person>>,
    // pub compositions: Option<Vec<Composition>>,
}

#[derive(Debug, Queryable)]
pub struct Person {
    pub first_name: Option<String>,
    pub last_name: Option<String>,
    pub aliases: Option<Vec<String>>,
    pub birth_date: Option<Date>,
    pub death_date: Option<Date>,
    pub is_alive: Option<bool>,
    pub full_name: Option<String>,
    pub age: Option<i32>,
    // pub compositions: Option<Composition>,
    // pub arrangements: Option<Composition>,
    // pub lyrics: Option<Composition>,
    pub is_composer: Option<bool>,
    pub is_arranger: Option<bool>,
    pub is_lyricist: Option<bool>,
    pub is_player: Option<bool>,
    // pub instruments: Option<Vec<Instrument>>,
}

#[derive(Debug, Queryable)]
pub enum NoteName {
    C,
    D,
    E,
    F,
    G,
    A,
    B,
}

#[derive(Debug, Queryable)]
pub enum Accidental {
    Flat,
    Natural,
    Sharp,
}

#[derive(Debug, Queryable)]
pub struct Note {
    pub name: Option<NoteName>,
    pub accidental: Option<Accidental>,
}

#[derive(Debug, Queryable)]
pub struct Instrument {
    pub name: Option<String>,
    pub aliases: Option<Vec<String>>,
    pub tuning: Option<Note>,
    // pub players: Option<Player>,
}

#[derive(Debug, Queryable)]
pub enum Mode {
    Major,
    Minor,
}

#[derive(Debug, Queryable)]
pub struct Key {
    pub root: Option<Note>,
    pub mode: Option<Mode>,
}

#[derive(Debug, Queryable)]
pub enum Denominator {
    One,
    Two,
    Four,
    Eight,
    Sixteen,
    ThirtyTwo,
    SixtyFour,
}

#[derive(Debug, Queryable)]
pub struct TimeSignature {
    pub numerator: Option<i32>,
    pub denominator: Option<Denominator>,
}

#[derive(Debug, Queryable)]
pub struct Composition {
    pub title: Option<String>,
    pub composers: Option<Vec<Person>>,
    pub lyricists: Option<Vec<Person>>,
    pub arrangers: Option<Vec<Person>>,
    pub composition_date: Option<Date>,
    pub arrangement_date: Option<Date>,
    pub instrumentation: Option<Instrument>,
    pub key: Option<Key>,
    pub time_signature: Option<TimeSignature>,
}

#[derive(Debug, Queryable)]
pub struct Player {
    pub person: Option<Person>,
    pub instrument: Option<Instrument>,
}

#[derive(Debug, Queryable)]
pub struct Artist {
    pub name: Option<String>,
    pub members: Option<Vec<Person>>,
    pub year_start: Option<Date>,
    pub year_end: Option<Date>,
    pub albums: Option<Vec<Album>>,
}

#[derive(Debug, Queryable)]
pub struct Track {
    pub title: Option<String>,
    pub compositions: Option<Vec<Composition>>,
    pub players: Option<Vec<Player>>,
    pub year_recorded: Option<Date>,
    pub year_released: Option<Date>,
    pub year_mastered: Option<Date>,
    pub year_mixed: Option<Date>,
    pub number: Option<i16>,
    pub duration: Option<Duration>,
}

#[derive(Debug, Queryable)]
pub struct Series {
    pub name: Option<String>,
    pub label: Option<Label>,
}

#[derive(Debug, Queryable)]
pub struct Label {
    pub name: Option<String>,
    pub series: Option<Vec<Series>>,
    pub albums: Option<Vec<Album>>,
    pub artists: Option<Vec<Artist>>,
}

#[derive(Debug, Queryable)]
pub struct Disc {
    pub title: Option<String>,
    pub number: Option<i32>,
    pub tracks: Option<Vec<Track>>,
}

#[derive(Debug, Queryable)]
pub struct Album {
    pub title: Option<String>,
    pub artists: Option<Vec<Artist>>,
    pub producers: Option<Vec<Person>>,
    pub discs: Option<Vec<Disc>>,
    pub label: Option<Label>,
    pub series: Option<Series>,
    pub series_number: Option<i32>,
    pub date_released: Option<Date>,
    pub disc_total: Option<i32>,
}
