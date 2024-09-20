FROM debian:12

LABEL maintainer="Mathieu Lemay <acidrain1@gmail.com>"

ENV UV_PYTHON_INSTALL_DIR=/opt/python
ENV UV_TOOL_DIR=/usr/local/share/uv/tools
ENV UV_TOOL_BIN_DIR=/usr/local/bin

RUN set -eu; \
    apt-get update; \
    apt-get install -y --no-install-recommends curl ca-certificates; \
    rm -rf /var/lib/apt/lists/*;

# Install uv
RUN set -eu; \
    curl -LsSf https://astral.sh/uv/install.sh \
        | INSTALLER_NO_MODIFY_PATH=1 UV_INSTALL_DIR=/usr/local sh;

# Install python versions
RUN set -eu; \
    for py_version in 3.8 3.9 3.10 3.11 3.12; do \
        uv python install ${py_version}; \
        ln -s "$(uv python find "${py_version}")" "/usr/local/bin/python${py_version}"; \
    done;

# Install poetry and tox
RUN set -eu; \
    uv tool install poetry; \
    uv tool install tox;

COPY ./entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

CMD [ "bash" ]
