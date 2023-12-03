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
    curl -sSL https://install.python-poetry.org | python -; \
    pip install tox; \
    \
    for py_version in 3.8 3.9 3.10 3.11 3.12; do \
        pyenv install ${py_version}; \
    done; \
    pyenv global $(pyenv versions --bare | sort --version-sort -r);
