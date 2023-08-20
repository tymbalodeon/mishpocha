use edgedb_derive::Queryable;
use edgedb_protocol::model::LocalDate;

#[derive(Debug, Queryable)]
pub struct Key {
    pub name: Option<String>,
}

#[derive(Debug, Queryable)]
pub struct TimeSignature {
    pub name: Option<String>,
}

#[derive(Debug, Queryable)]
pub struct Composition {
    pub title: Option<String>,
    pub composers: Option<Vec<Person>>,
    pub lyricists: Option<Vec<Person>>,
    pub arrangers: Option<Vec<Person>>,
    pub composition_date: Option<LocalDate>,
    pub instrumentation: Option<Instrument>,
    pub key: Option<Key>,
    pub time_signature: Option<TimeSignature>,
}

#[derive(Debug, Queryable)]
pub struct Date {
    pub day: Option<i16>,
    pub month: Option<i16>,
    pub year: Option<Vec<i32>>,
    pub display: Option<String>,
    pub local_date: Option<LocalDate>,
    pub birhtdays: Option<Vec<Person>>,
    pub deathdays: Option<Vec<Person>>,
    pub compositions: Option<Vec<Composition>>,
}

#[derive(Debug, Queryable)]
pub struct Person {
    pub full_name: Option<String>,
    pub last_name: Option<String>,
    pub aliases: Option<Vec<String>>,
    pub birth_date: Option<String>,
}

#[derive(Debug, Queryable)]
pub struct Instrument {
    pub name: Option<String>,
}
