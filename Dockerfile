# Use a recent Ubuntu LTS version as the base image
FROM ubuntu:22.04

# Avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install base dependencies, sudo, git, zsh, python, node, build tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    git \
    curl \
    build-essential \
    zsh \
    python3 \
    python3-pip \
    nodejs \
    npm \
    # Add any other essential system packages your deploy script *always* needs
    # For example, if fzf is always needed for basic setup:
    fzf \
    # Clean up apt cache
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a non-root user 'tester' with sudo privileges and zsh shell
RUN useradd --create-home --shell /bin/zsh tester && \
    adduser tester sudo && \
    # Grant passwordless sudo to the sudo group
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Set environment variables for the user
ENV USER=tester
ENV HOME=/home/tester

# Copy the entire dotfiles directory into the container
# Assumes Dockerfile is in the root of the dotfiles repo
COPY --chown=tester:tester . ${HOME}/dotfiles

# Switch to the non-root user
USER ${USER}

# Set the working directory
WORKDIR ${HOME}/dotfiles

# Default command to run the deploy script non-interactively
# Pipes 'yes' to automatically answer prompts in the script
CMD ["/bin/zsh", "-c", "yes | ./deploy"]
