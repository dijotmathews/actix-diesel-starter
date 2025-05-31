FROM rust:1.87-bullseye AS builder
WORKDIR /app
COPY . .
RUN cargo build --release


FROM debian:bullseye-slim AS runner
RUN apt-get update && apt-get -y install libpq-dev && rm -rf /var/lib/apt/lists/*
EXPOSE 8080
COPY --from=builder /app/target/release/events_api /app/target/release/eventsapi
COPY migrations /app/target/release/migrations
CMD ["/app/target/release/eventsapi"]
