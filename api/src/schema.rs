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
    pub aliases: Option<Vec<String>>,
    pub birth_date: Option<Date>,
    pub death_date: Option<Date>,
    pub is_alive: Option<bool>,
    pub full_name: Option<String>,
    pub age: Option<Vec<i32>>,
    pub compositions: Option<Vec<Composition>>,
    pub arrangements: Option<Vec<Composition>>,
    pub lyrics: Option<Vec<Composition>>,
    pub tracks: Option<Vec<Track>>,
    pub is_composer: Option<bool>,
    pub is_arranger: Option<bool>,
    pub is_lyricist: Option<bool>,
    pub is_player: Option<bool>,
    pub is_producer: Option<bool>,
    pub instruments: Option<Vec<Instrument>>,
    pub groups: Option<Vec<Artist>>,
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
    pub id: Option<Uuid>,
    pub name: Option<String>,
    pub aliases: Option<Vec<String>>,
    pub tuning: Option<Note>,
    pub players: Option<Vec<Player>>,
    pub player_names: Option<Vec<String>>,
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
    pub id: Option<Uuid>,
    pub title: Option<String>,
    pub composers: Option<Vec<Person>>,
    pub lyricists: Option<Vec<Person>>,
    pub arrangers: Option<Vec<Person>>,
    pub date_composed: Option<Date>,
    pub date_arranged: Option<Date>,
    pub instrumentation: Option<Vec<Instrument>>,
    pub key: Option<Key>,
    pub time_signature: Option<TimeSignature>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Player {
    pub id: Option<Uuid>,
    pub person: Option<Person>,
    pub instrument: Option<Instrument>,
    pub display: Option<String>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Artist {
    pub id: Option<Uuid>,
    pub name: Option<String>,
    pub members: Option<Vec<Person>>,
    pub date_start: Option<Date>,
    pub date_end: Option<Date>,
    pub albums: Option<Vec<Album>>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Track {
    pub id: Option<Uuid>,
    pub title: Option<String>,
    pub compositions: Option<Vec<Composition>>,
    pub players: Option<Vec<Player>>,
    pub date_recorded: Option<Date>,
    pub date_released: Option<Date>,
    pub date_mastered: Option<Date>,
    pub date_mixed: Option<Date>,
    pub number: Option<i16>,
    pub duration: Option<String>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Series {
    pub id: Option<Uuid>,
    pub name: Option<String>,
    pub label: Option<Vec<Label>>,
    pub albums: Option<Vec<Album>>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Label {
    pub id: Option<Uuid>,
    pub name: Option<String>,
    pub series: Option<Vec<Series>>,
    pub albums: Option<Vec<Album>>,
    pub artists: Option<Vec<Artist>>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Disc {
    pub id: Option<Uuid>,
    pub disc_title: Option<Vec<String>>,
    pub number: Option<i32>,
    pub tracks: Option<Vec<Track>>,
    pub album: Option<Album>,
    pub title: Option<Vec<String>>,
    pub duration: Option<String>,
}

#[derive(Debug, Deserialize, Queryable, Serialize)]
#[edgedb(json)]
pub struct Album {
    pub id: Option<Uuid>,
    pub title: Option<String>,
    pub artists: Option<Vec<Artist>>,
    pub producers: Option<Vec<Person>>,
    pub discs: Option<Vec<Disc>>,
    pub label: Option<Label>,
    pub catalog_number: Option<i32>,
    pub series: Option<Series>,
    pub series_number: Option<i32>,
    pub date_released: Option<Date>,
    pub date_recorded: Option<Date>,
    pub tracks: Option<Vec<Track>>,
    pub disc_total: Option<i32>,
    pub duration: Option<String>,
}
