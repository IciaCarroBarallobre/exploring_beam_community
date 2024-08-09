# Define build arguments for Elixir, OTP, and Debian versions
ARG ELIXIR_VERSION=1.16.2
ARG OTP_VERSION=26.2.2
ARG DEBIAN_VERSION=bullseye-20240130-slim

# Use a hexpm Elixir image as the builder
ARG BUILDER_IMAGE="hexpm/elixir:${ELIXIR_VERSION}-erlang-${OTP_VERSION}-debian-${DEBIAN_VERSION}"
ARG RUNNER_IMAGE="debian:${DEBIAN_VERSION}"

FROM ${BUILDER_IMAGE} as builder

# Install system dependencies and Node.js
RUN apt-get update -y && \
    apt-get install -y build-essential git curl unzip && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Set environment to production
ENV MIX_ENV="prod"

# Copy and fetch dependencies
COPY mix.exs mix.lock ./
RUN mix deps.get --only $MIX_ENV

# Copy configuration files
RUN mkdir config
COPY config/config.exs config/${MIX_ENV}.exs config/
RUN mix deps.compile

# Copy the application code
COPY priv priv
COPY lib lib

# Copy assets and install Node.js dependencies
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm install --prefix ./assets

# Download Heroicons
RUN mkdir -p assets/vendor/heroicons/optimized && \
    curl -L https://github.com/tailwindlabs/heroicons/archive/refs/heads/main.zip -o heroicons.zip && \
    unzip heroicons.zip -d assets/vendor/heroicons/ && \
    mv assets/vendor/heroicons/heroicons-main/optimized/* assets/vendor/heroicons/optimized && \
    rm -rf heroicons.zip assets/vendor/heroicons/heroicons-main

# Compile assets
COPY assets assets
RUN npm run deploy --prefix ./assets && mix phx.digest

# Compile the application
RUN mix compile

# Copy runtime configuration files
COPY config/runtime.exs config/

# Copy release configuration
COPY rel rel
RUN mix release

# Start a new stage for the final image
FROM ${RUNNER_IMAGE}

# Install runtime dependencies
RUN apt-get update -y && \
    apt-get install -y libstdc++6 openssl libncurses5 locales ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

# Set environment variables for locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set the working directory
WORKDIR "/app"

# Set permissions
RUN chown nobody /app

# Set environment to production
ENV MIX_ENV="prod"

# Copy the compiled release from the builder
COPY --from=builder --chown=nobody:root /app/_build/${MIX_ENV}/rel/exploring_beam_community ./

# Switch to a non-root user
USER nobody

# Start the application
CMD ["/app/bin/server"]