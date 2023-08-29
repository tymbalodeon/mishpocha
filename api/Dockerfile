FROM rust as base
WORKDIR /api
COPY Cargo.toml Cargo.toml
COPY Cargo.lock Cargo.lock
COPY src src

FROM base as dev
WORKDIR /api
RUN cargo build
CMD ["cargo", "run"]

FROM base as prod
WORKDIR /api
RUN cargo build --release
CMD ["./target/release/mishpocha-api"]
