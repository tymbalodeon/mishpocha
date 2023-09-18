mod schema;
use shuttle_actix_web::ShuttleActixWeb;
use std::env::var_os;
use std::path::PathBuf;
use uuid::Uuid;

use actix_web::{
    get,
    web::{Json, Path, ServiceConfig},
    HttpResponse, Responder, Result,
};
use edgedb_tokio::create_client;
use schema::{
    Album, Artist, Composition, Date, Instrument, Label, Person, Player,
    Series, Track,
};

#[get("/")]
async fn welcome() -> impl Responder {
    let key = "CHECK_ONE_TWO";
    let value = match var_os(key) {
        Some(val) => format!("{key}: {val:?}"),
        None => format!("{key} is not defined in the environment."),
    };
    HttpResponse::Ok().body(value)
}

#[get("/dates")]
async fn get_dates() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let dates: Vec<Date> = client
        .query(
            "select <json>(
                select Date { ** }
                order by .local_date
            );",
            &(),
        )
        .await
        .unwrap();

    Ok(Json(dates))
}

#[get("/dates/{id}")]
async fn get_date(path: Path<Uuid>) -> Result<impl Responder> {
    let date_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let date: Option<Date> = client
        .query_single(
            "select <json>(
                select Date { ** }
                filter .id = <uuid>$0
            );",
            &(date_id,),
        )
        .await
        .unwrap();

    Ok(Json(date))
}

#[get("/people")]
async fn get_people() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let dates: Vec<Person> = client
        .query(
            "select <json>(
                select Person { ** }
                order by .last_name
            );",
            &(),
        )
        .await
        .unwrap();

    Ok(Json(dates))
}

#[get("/people/{id}")]
async fn get_person(path: Path<Uuid>) -> Result<impl Responder> {
    let person_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let person: Option<Person> = client
        .query_single(
            "select <json>(
                select Person { ** }
                filter .id = <uuid>$0
            );",
            &(person_id,),
        )
        .await
        .unwrap();

    Ok(Json(person))
}

#[get("/instruments")]
async fn get_instruments() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let instruments: Vec<Instrument> = client
        .query(
            "
            select <json>(
                select Instrument {
                    **,
                    players: { display, person: { id, display } }
                } order by .display
            );",
            &(),
        )
        .await
        .unwrap();

    Ok(Json(instruments))
}

#[get("/instruments/{id}")]
async fn get_instrument(path: Path<Uuid>) -> Result<impl Responder> {
    let instrument_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let instrument: Option<Instrument> = client
        .query_single(
            "select <json>(
                select Instrument {
                    **,
                    players: { display, person: { id, display } }
                }
                filter .id = <uuid>$0
            );",
            &(instrument_id,),
        )
        .await
        .unwrap();

    Ok(Json(instrument))
}

#[get("/compositions")]
async fn get_compositions() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let compositions: Vec<Composition> = client
        .query(
            "select <json>(
                select Composition { ** }
                order by .title
            );",
            &(),
        )
        .await
        .unwrap();

    Ok(Json(compositions))
}

#[get("/compositions/{id}")]
async fn get_composition(path: Path<Uuid>) -> Result<impl Responder> {
    let composition_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let compositions: Option<Composition> = client
        .query_single(
            "select <json>(
                select Composition { ** }
                filter .id = <uuid>$0
            );",
            &(composition_id,),
        )
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
        .query(
            "select <json>(
                select Player { ** }
                order by .person.last_name
            );",
            &(),
        )
        .await
        .unwrap();

    Ok(Json(players))
}

#[get("/players/{id}")]
async fn get_player(path: Path<Uuid>) -> Result<impl Responder> {
    let player_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let player: Option<Player> = client
        .query_single(
            "select <json>(
                select Player { ** }
                filter .id = <uuid>$0
            );",
            &(player_id,),
        )
        .await
        .unwrap();

    Ok(Json(player))
}

#[get("/artists")]
async fn get_artists() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let artists: Vec<Artist> = client
        .query("select <json>(select Artist { ** } order by .name);", &())
        .await
        .unwrap();

    Ok(Json(artists))
}

#[get("/artists/{id}")]
async fn get_artist(path: Path<Uuid>) -> Result<impl Responder> {
    let artist_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let artist: Option<Artist> = client
        .query_single(
            "select <json>(
                select Artist { ** }
                filter .id = <uuid>$0
            );",
            &(artist_id,),
        )
        .await
        .unwrap();

    Ok(Json(artist))
}

#[get("/tracks")]
async fn get_tracks() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let tracks: Vec<Track> = client
        .query(
            "select <json>(
                select Track {
                    **,
                    players: {
                        person: { id, display }
                    }
                } order by .title
            );",
            &(),
        )
        .await
        .unwrap();

    Ok(Json(tracks))
}

#[get("/tracks/{id}")]
async fn get_track(path: Path<Uuid>) -> Result<impl Responder> {
    let track_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let track: Option<Track> = client
        .query_single(
            "select <json>(
                select Track { ** }
                filter .id = <uuid>$0
            );",
            &(track_id,),
        )
        .await
        .unwrap();

    Ok(Json(track))
}

#[get("/series")]
async fn get_series() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let series: Vec<Series> = client
        .query("select <json>(select Series { ** } order by .name);", &())
        .await
        .unwrap();

    Ok(Json(series))
}

#[get("/series/{id}")]
async fn get_series_by_id(path: Path<Uuid>) -> Result<impl Responder> {
    let series_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let series: Option<Series> = client
        .query_single(
            "select <json>(
                select Series { ** }
                filter .id = <uuid>$0
            );",
            &(series_id,),
        )
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
        .query("select <json>(select Label { ** } order by .name);", &())
        .await
        .unwrap();

    Ok(Json(labels))
}

#[get("/labels/{id}")]
async fn get_label(path: Path<Uuid>) -> Result<impl Responder> {
    let label_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let label: Option<Label> = client
        .query_single(
            "select <json>(
                select Label { ** }
                filter .id = <uuid>$0
            );",
            &(label_id,),
        )
        .await
        .unwrap();

    Ok(Json(label))
}

#[get("/albums")]
async fn get_albums() -> Result<impl Responder> {
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let albums: Vec<Album> = client
        .query("select <json>(select Album { ** } order by .title);", &())
        .await
        .unwrap();

    Ok(Json(albums))
}

#[get("/albums/{id}")]
async fn get_album(path: Path<Uuid>) -> Result<impl Responder> {
    let album_id = path.into_inner();
    let client = create_client()
        .await
        .expect("Failed to connect to database");
    let album: Option<Album> = client
        .query_single(
            "select <json>(
                select Album { ** }
                filter .id = <uuid>$0
            );",
            &(album_id,),
        )
        .await
        .unwrap();

    Ok(Json(album))
}

#[shuttle_runtime::main]
async fn main(
    #[shuttle_env_vars::EnvVars()] _env_folder: PathBuf,
) -> ShuttleActixWeb<impl FnOnce(&mut ServiceConfig) + Send + Clone + 'static>
{
    let config = move |cfg: &mut ServiceConfig| {
        cfg.service(welcome)
            .service(get_dates)
            .service(get_date)
            .service(get_people)
            .service(get_person)
            .service(get_instruments)
            .service(get_instrument)
            .service(get_compositions)
            .service(get_composition)
            .service(get_players)
            .service(get_player)
            .service(get_artists)
            .service(get_artist)
            .service(get_tracks)
            .service(get_track)
            .service(get_series)
            .service(get_series_by_id)
            .service(get_labels)
            .service(get_label)
            .service(get_albums)
            .service(get_album);
    };

    Ok(config.into())
}
