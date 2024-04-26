FROM rust:bookworm as builder

WORKDIR /tendermintx
COPY . /tendermintx

RUN cargo build --release --bin tendermintx


FROM debian:bookworm-slim

RUN apt-get update && apt-get upgrade && apt-get install -y \
    libssl3 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /tendermintx/target/release/tendermintx /usr/local/bin/tendermintx

ENTRYPOINT ["/usr/local/bin/tendermintx"]
