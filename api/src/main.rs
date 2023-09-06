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
        .query(
            "select <json>(
                select Date { ** } order by .local_date
        );",
            &(),
        )
        .await
        .unwrap();

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
        .unwrap();

    Ok(Json(dates))
}

#[get("/instruments")]
async fn get_instruments() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let instruments: Vec<Instrument> = client
        .query(
            "
            select <json>Instrument {
                **,
                players: { display, person: { id, display } }
            };",
            &(),
        )
        .await
        .unwrap();

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
        .unwrap();

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
        .unwrap();

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
        .unwrap();

    Ok(Json(artists))
}

#[get("/tracks")]
async fn get_tracks() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let tracks: Vec<Track> = client
        .query(
            "select <json>Track {
            **,
            players: { person: { id, display } }
        };",
            &(),
        )
        .await
        .unwrap();

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
        .unwrap();

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
        .unwrap();

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
        .unwrap();

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
