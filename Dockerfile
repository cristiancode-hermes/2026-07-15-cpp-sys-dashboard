# Stage 1: Build
FROM gcc:14-bookworm AS builder
RUN apt-get update && apt-get install -y cmake pkg-config
WORKDIR /src
COPY CMakeLists.txt CMakePresets.json ./
COPY src/ include/ tests/ ./
RUN cmake -G "Unix Makefiles" -S . -B build -DCMAKE_BUILD_TYPE=Release && \
    cmake --build build

# Stage 2: Runtime (~25 MB)
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /src/build/sys-dashboard /usr/local/bin/sys-dashboard
ENTRYPOINT ["sys-dashboard"]
