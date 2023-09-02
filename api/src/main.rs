mod schema;

use actix_web::{
    get, web::Json, App, HttpResponse, HttpServer, Responder, Result,
};
use edgedb_tokio::create_client;
use schema::{
    Album, Artist, Composition, Date, Instrument, Label, Person, Player,
    Series, Track,
};

#[get("/")]
async fn welcome() -> impl Responder {
    HttpResponse::Ok().body("Welcome to the Mishpocha database!")
}

#[get("/dates")]
async fn get_dates() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let dates: Vec<Date> = client
        .query("select <json>Date { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(dates))
}

#[get("/people")]
async fn get_people() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let dates: Vec<Person> = client
        .query("select <json>Person { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(dates))
}

#[get("/instruments")]
async fn get_instruments() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let instruments: Vec<Instrument> = client
        .query("select <json>Instrument { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(instruments))
}

#[get("/compositions")]
async fn get_compositions() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let compositions: Vec<Composition> = client
        .query("select <json>Composition { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(compositions))
}

#[get("/players")]
async fn get_players() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let players: Vec<Player> = client
        .query("select <json>Player { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(players))
}

#[get("/artists")]
async fn get_artists() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let artists: Vec<Artist> = client
        .query("select <json>Artist { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(artists))
}

#[get("/tracks")]
async fn get_tracks() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let tracks: Vec<Track> = client
        .query("select <json>Track { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(tracks))
}

#[get("/series")]
async fn get_series() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let series: Vec<Series> = client
        .query("select <json>Series { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(series))
}

#[get("/labels")]
async fn get_labels() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let labels: Vec<Label> = client
        .query("select <json>Label { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(labels))
}

#[get("/albums")]
async fn get_albums() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let albums: Vec<Album> = client
        .query("select <json>Album { ** };", &())
        .await
        .expect("Bad query");

    Ok(Json(albums))
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(welcome)
            .service(get_dates)
            .service(get_people)
            .service(get_instruments)
            .service(get_compositions)
            .service(get_players)
            .service(get_artists)
            .service(get_tracks)
            .service(get_series)
            .service(get_labels)
            .service(get_albums)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}
