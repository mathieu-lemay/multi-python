FROM python

LABEL maintainer "Mathieu Lemay <acidrain1@gmail.com>"

ENV PYENV_ROOT=/opt/pyenv
ENV POETRY_HOME=/opt/poetry
ENV PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${POETRY_HOME}/bin:${PATH}"
ENV PYENV_SHELL=bash

RUN set -eu; \
    git clone https://github.com/pyenv/pyenv.git "${PYENV_ROOT}"; \
    "${PYENV_ROOT}/src/configure"; \
    make -C "${PYENV_ROOT}/src"; \
    \
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -; \
    pip install tox; \
    \
    pyenv_plugin_root="${PYENV_ROOT}/plugins"; \
    mkdir -p "${pyenv_plugin_root}"; \
    git clone https://github.com/momo-lab/xxenv-latest.git "${pyenv_plugin_root}/xxenv-latest";\
    \
    for py_version in 3.6 3.7 3.8 3.9; do \
        pyenv latest install ${py_version}; \
    done; \
    pyenv global $(pyenv versions --bare | sort --version-sort -r);
