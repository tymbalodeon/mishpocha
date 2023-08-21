use actix_web::{
    get, post,
    web::{Json, Query},
    App, HttpResponse, HttpServer, Responder,
};
use serde::Deserialize;

#[get("/")]
async fn welcome() -> impl Responder {
    HttpResponse::Ok().body("Welcome to the Mishpocha database!")
}

#[get("/date")]
async fn get_dates() -> impl Responder {
    let client = edgedb_tokio::create_client()
        .await
        .expect("Failed to connect to database");
    HttpResponse::Ok().body(
        client
            .query_json("select Date {*};", &())
            .await
            .expect("failed to execute query")
            .to_string(),
    )
}

#[get("/people")]
async fn get_people() -> impl Responder {
    let client = edgedb_tokio::create_client()
        .await
        .expect("Failed to connect to database");
    HttpResponse::Ok().body(
        client
            .query_json("select Person {*};", &())
            .await
            .expect("failed to execute query")
            .to_string(),
    )
}

#[derive(Deserialize)]
struct FullName {
    full_name: String,
}

#[get("/person")]
async fn get_person(query: Query<FullName>) -> impl Responder {
    let client = edgedb_tokio::create_client()
        .await
        .expect("Failed to connect to database");
    HttpResponse::Ok().body(
        client
            .query_json(
                "
                select Person { * }
                filter {
                    .full_name = <str>$0
                };
                ",
                &(&query.full_name,),
            )
            .await
            .expect("failed to execute query")
            .to_string(),
    )
}

#[derive(Deserialize)]
struct Person {
    first_name: String,
    last_name: String,
}

#[post("/person")]
async fn post_person(person: Json<Person>) -> impl Responder {
    let client = edgedb_tokio::create_client()
        .await
        .expect("Failed to connect to database");
    HttpResponse::Ok().body(
        client
            .query_json(
                "
                insert Person {
                    first_name := <str>$0,
                    last_name := <str>$1
                };
                ",
                &(&person.first_name, &person.last_name),
            )
            .await
            .expect("failed to execute query")
            .to_string(),
    )
}

#[get("/instruments")]
async fn get_instruments() -> impl Responder {
    let client = edgedb_tokio::create_client()
        .await
        .expect("Failed to connect to database");
    HttpResponse::Ok().body(
        client
            .query_json("select Instrument { * };", &())
            .await
            .expect("failed to execute query")
            .to_string(),
    )
}

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .service(welcome)
            .service(get_dates)
            .service(get_people)
            .service(post_person)
            .service(get_person)
            .service(get_instruments)
    })
    .bind(("127.0.0.1", 8080))?
    .run()
    .await
}
