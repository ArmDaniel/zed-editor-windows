FROM rust:latest

WORKDIR /app

# We are gonna install all dependencies here, please refer to docs for specifics
RUN apt-get update && apt-get install -y \
    clang \  
    mold \
    libasound2-dev \
    libxcb-composite0-dev \
    libxcursor-dev \
    libxi-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libxkbcommon-dev \
    libxkbcommon-x11-dev \
    libvulkan1 \           
    mesa-vulkan-drivers        
    

# Create the rustc configuration directory
RUN mkdir -p /etc/rustc

# Set mold as the default linker globally
RUN echo 'linker = "mold"' >> /etc/rustc/config.toml 

RUN git clone https://github.com/zed-industries/zed.git
WORKDIR /app/zed

# Build and install Zed
RUN cargo build --release -j2

# Set the path to the Zed executable
ENV PATH="/app/zed/target/release:${PATH}"

CMD ["zed"]
