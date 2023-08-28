FROM rust as base
WORKDIR /api
COPY . .
RUN cargo build

FROM base as dev
WORKDIR /api
CMD ["./target/debug/mishpocha-api"]

FROM base as prod
WORKDIR /api
CMD ["./target/release/mishpocha-api"]
