use edgedb_derive::Queryable;
use serde::{Deserialize, Serialize};
use uuid::Uuid;

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Date {
    pub id: Option<Uuid>,
    pub day: Option<i16>,
    pub month: Option<i16>,
    pub year: Option<i32>,
    pub display: Option<String>,
    pub births: Option<Vec<Person>>,
    pub deaths: Option<Vec<Person>>,
    pub artist_starts: Option<Vec<Artist>>,
    pub artist_ends: Option<Vec<Artist>>,
    pub compositions: Option<Vec<Composition>>,
    pub arrangements: Option<Vec<Composition>>,
    pub tracks_recorded: Option<Vec<Track>>,
    pub tracks_released: Option<Vec<Track>>,
    pub tracks_mastered: Option<Vec<Track>>,
    pub tracks_mixed: Option<Vec<Track>>,
    pub albums_released: Option<Vec<Album>>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Person {
    pub id: Option<Uuid>,
    pub first_name: Option<String>,
    pub last_name: Option<String>,
    pub full_name: Option<String>,
    pub aliases: Option<Vec<String>>,
    pub birth_date: Option<Date>,
    pub death_date: Option<Date>,
    pub is_alive: Option<bool>,
    pub age: Option<Vec<i32>>,
    pub is_composer: Option<bool>,
    pub is_arranger: Option<bool>,
    pub is_lyricist: Option<bool>,
    pub is_player: Option<bool>,
    pub is_producer: Option<bool>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub enum NoteName {
    C,
    D,
    E,
    F,
    G,
    A,
    B,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub enum Accidental {
    Flat,
    Natural,
    Sharp,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Note {
    pub name: Option<NoteName>,
    pub accidental: Option<Accidental>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Instrument {
    pub name: Option<String>,
    pub aliases: Option<Vec<String>>,
    pub tuning: Option<Note>,
    // pub players: Option<Player>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub enum Mode {
    Major,
    Minor,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Key {
    pub root: Option<Note>,
    pub mode: Option<Mode>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub enum Denominator {
    One,
    Two,
    Four,
    Eight,
    Sixteen,
    ThirtyTwo,
    SixtyFour,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct TimeSignature {
    pub numerator: Option<i32>,
    pub denominator: Option<Denominator>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
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

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Player {
    pub person: Option<Person>,
    pub instrument: Option<Instrument>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Artist {
    pub name: Option<String>,
    pub members: Option<Vec<Person>>,
    pub year_start: Option<Date>,
    pub year_end: Option<Date>,
    pub albums: Option<Vec<Album>>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Track {
    pub title: Option<String>,
    pub compositions: Option<Vec<Composition>>,
    pub players: Option<Vec<Player>>,
    pub year_recorded: Option<Date>,
    pub year_released: Option<Date>,
    pub year_mastered: Option<Date>,
    pub year_mixed: Option<Date>,
    pub number: Option<i16>,
    pub duration: Option<String>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Series {
    pub name: Option<String>,
    pub label: Option<Label>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Label {
    pub name: Option<String>,
    pub series: Option<Vec<Series>>,
    pub albums: Option<Vec<Album>>,
    pub artists: Option<Vec<Artist>>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Disc {
    pub title: Option<String>,
    pub number: Option<i32>,
    pub tracks: Option<Vec<Track>>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Album {
    pub id: Option<Uuid>,
    pub title: Option<String>,
    pub disc_total: Option<i32>,
    pub duration: Option<String>,
    pub catalog_number: Option<i32>,
    pub series_number: Option<i32>,
    pub date_recorded: Option<Date>,
    pub date_released: Option<Date>,
    pub producers: Option<Vec<Person>>,
    pub artists: Option<Vec<Artist>>,
    pub discs: Option<Vec<Disc>>,
    pub label: Option<Label>,
    pub series: Option<Series>,
    pub tracks: Option<Vec<Track>>,
}
