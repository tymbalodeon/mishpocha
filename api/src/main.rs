mod schema;

use actix_web::{get, App, HttpResponse, HttpServer, Responder};
use schema::{Instrument, Person};

#[get("/")]
async fn welcome() -> impl Responder {
    HttpResponse::Ok().body("Welcome to the Mishpocha database!")
}

#[get("/person")]
async fn get_person() -> impl Responder {
    let client = edgedb_tokio::create_client()
        .await
        .expect("Failed to connect to database");
    let query = "select Person {*};";
    let person: Vec<Person> = client
        .query(query, &())
        .await
        .expect("failed to execute query");
    let result = person
        .into_iter()
        .map(|p| format!("{:?}", p))
        .collect::<Vec<String>>()
        .join("\n");
    HttpResponse::Ok().body(result)
}

#[get("/instrument")]
async fn get_instrument() -> impl Responder {
    let client = edgedb_tokio::create_client()
        .await
        .expect("Failed to connect to database");
    let query = "select Instrument { name };";
    let instrument: Vec<Instrument> = client
        .query(query, &())
        .await
        .expect("failed to execute query");
    let result = instrument
        .into_iter()
        .map(|p| format!("{:?}", p))
        .collect::<Vec<String>>()
        .join("\n");
    HttpResponse::Ok().body(result)
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(welcome)
            .service(get_person)
            .service(get_instrument)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
