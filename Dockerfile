FROM julia:1.7-alpine

RUN mkdir /app
WORKDIR /app

# Add PackageCompiler to the global environment.
RUN julia -e 'using Pkg; Pkg.add(; name="PackageCompiler", version="2.0.5")'

# See also https://github.com/docker-library/postgres/blob/master/14/alpine/Dockerfile
RUN set -eux; \
    apk add --update --no-cache \
        build-base \
        coreutils \
        g++ \
        krb5-dev \
        libc-dev \
        libedit-dev \
        libxml2-dev \
        libxslt-dev \
        linux-headers \
        llvm-dev clang g++ \
        make

# Copy the `Project.toml` and an empty `src/YSF.jl` module.
COPY Project.toml /app/
RUN mkdir -p /app/src/; \
  echo 'module MyApp end' > /app/src/MyApp.jl ; \
  julia --project -e 'using Pkg; Pkg.instantiate(); Pkg.precompile()'

# Generate sysimage.
COPY scripts/build-sysimage.jl /app/scripts/
COPY scripts/precompile-execution.jl /app/scripts/
RUN julia --project scripts/build-sysimage.jl

# Copy source code.
COPY src/ /app/src/
COPY scripts/start-server.jl /app/scripts/

CMD ["julia", "--project", "--sysimage", "img.so", "scripts/start-server.jl"]
