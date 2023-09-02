mod schema;

use actix_web::{
    get, web::Json, App, HttpResponse, HttpServer, Responder, Result,
};
use edgedb_tokio::create_client;
use schema::{Date, Person};

#[get("/")]
async fn welcome() -> impl Responder {
    HttpResponse::Ok().body("Welcome to the Mishpocha database!")
}

// #[post("/date")]
// async fn post_date(date: Json<Date>) -> impl Responder {
//     let client = create_client()
//         .await
//         .expect("Failed to connect to database");
//     HttpResponse::Ok().body(
//         client
//             .query_json(
//                 "
//                 insert Date {
//                     day := <int16>$0,
//                     month := <int16>$1,
//                     year := <int32>$2
//                 } unless conflict;
//                 ",
//                 &(&date.day, &date.month, &date.year),
//             )
//             .await
//             .expect("failed to execute query")
//             .to_string(),
//     )
// }

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

// #[post("/person")]
// async fn post_person(person: Json<Person>) -> impl Responder {
//     let client = create_client()
//         .await
//         .expect("Failed to connect to database");
//     HttpResponse::Ok().body(
//         client
//             .query_json(
//                 "
//                 insert Person {
//                     first_name := <str>$0,
//                     last_name := <str>$1,
//                     birth_date := (
//                         select Date
//                         filter .display = <str>$2
//                         limit 1
//                     )
//                 } unless conflict;
//                 ",
//                 &(
//                     &person.first_name,
//                     &person.last_name,
//                     &person.birthdate_display,
//                 ),
//             )
//             .await
//             .expect("failed to execute query")
//             .to_string(),
//     )
// }

// #[derive(Deserialize)]
// struct FullName {
//     full_name: String,
// }

// #[get("/person")]
// async fn get_person(query: Query<FullName>) -> impl Responder {
//     let client = create_client()
//         .await
//         .expect("Failed to connect to database");
//     HttpResponse::Ok().body(
//         client
//             .query_json(
//                 "
//                 select Person { ** }
//                 filter {
//                     .full_name = <str>$0
//                 };
//                 ",
//                 &(&query.full_name,),
//             )
//             .await
//             .expect("failed to execute query")
//             .to_string(),
//     )
// }

// #[derive(Deserialize)]
// struct Instrument {
//     name: String,
// }

// #[post("/instrument")]
// async fn post_instrument(instrument: Json<Instrument>) -> impl Responder {
//     let client = create_client()
//         .await
//         .expect("Failed to connect to database");
//     HttpResponse::Ok().body(
//         client
//             .query_json(
//                 "
//                 insert Instrument {
//                     name := <str>$0
//                 } unless conflict;
//                 ",
//                 &(&instrument.name,),
//             )
//             .await
//             .expect("failed to execute query")
//             .to_string(),
//     )
// }

// #[get("/instruments")]
// async fn get_instruments() -> impl Responder {
//     let client = create_client()
//         .await
//         .expect("Failed to connect to database");
//     HttpResponse::Ok().body(
//         client
//             .query_json("select Instrument { ** };", &())
//             .await
//             .expect("failed to execute query")
//             .to_string(),
//     )
// }

// #[derive(Deserialize)]
// struct Player {
//     person_name: String,
//     instrument_name: String,
// }

// #[post("/player")]
// async fn post_player(player: Json<Player>) -> impl Responder {
//     let client = create_client()
//         .await
//         .expect("Failed to connect to database");
//     HttpResponse::Ok().body(
//         client
//             .query_json(
//                 "
//                 insert Player {
//                     person := (
//                         select Person
//                         filter .full_name = <str>$0
//                         limit 1
//                     ),
//                     instrument := (
//                         select Instrument
//                         filter .name = <str>$1
//                         limit 1
//                     )
//                 } unless conflict;
//                 ",
//                 &(&player.person_name, &player.instrument_name),
//             )
//             .await
//             .expect("failed to execute query")
//             .to_string(),
//     )
// }

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(welcome)
            .service(get_dates)
            .service(get_people)
    })
    .bind(("0.0.0.0", 8080))?
    .run()
    .await
}
