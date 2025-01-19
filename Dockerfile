FROM debian:12

LABEL maintainer="Mathieu Lemay <acidrain1@gmail.com>"

RUN set -eu; \
    apt-get update; \
    apt-get install -y --no-install-recommends curl ca-certificates; \
    rm -rf /var/lib/apt/lists/*;

# Install uv
RUN set -eu; \
    curl -LsSf https://astral.sh/uv/install.sh \
        | INSTALLER_NO_MODIFY_PATH=1 UV_INSTALL_DIR=/usr/local/bin sh;

ENV UV_PYTHON_INSTALL_DIR=/opt/python
ENV UV_PYTHON_BIN_DIR=/usr/local/bin

# Install python versions
RUN set -eu; \
    for py_version in 3.9 3.10 3.11 3.12 3.13; do \
        uv python install --preview ${py_version}; \
    done;

ENV UV_TOOL_DIR=/usr/local/share/uv/tools
ENV UV_TOOL_BIN_DIR=/usr/local/bin

# Install poetry and tox
RUN set -eu; \
    uv tool install poetry; \
    uv tool install tox;
