FROM rust as base
WORKDIR /api
COPY . .

FROM base as dev
WORKDIR /api
CMD ["cargo", "run"]

FROM base as prod
WORKDIR /api
RUN cargo build --release
CMD ["./target/release/mishpocha-api"]
