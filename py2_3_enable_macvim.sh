#!/bin/bash

# PYTHON_CONFIGURE_OPTS="--enable-shared" \
#     LDSHARED="clang -bundle" \
#     LDCXXSHARED="clang++ -bundle" \
#     BLDSHARED="clang -bundle -lpython2.7" \
#     pyenv install 2.7.14

# PYTHON_CONFIGURE_OPTS="--enable-shared" \
#     LDSHARED="clang -bundle" \
#     LDCXXSHARED="clang++ -bundle" \
#     BLDSHARED="clang -bundle -lpython3.6m" \
#     pyenv install 3.6.4

PYTHON_CONFIGURE_OPTS="--enable-shared --with-threads" \
    LDSHARED="clang -bundle" \
    LDCXXSHARED="clang++ -bundle" \
    BLDSHARED="clang -bundle -lpython2.7" \
    # LDSHARED="clang -undefined dynamic_lookup -bundle"\
    # LDCXXSHARED="clang++ -undefined dynamic_lookup -bundle" \
    # BLDSHARED="clang -bundle -undefined dynamic_lookup -lpython2.7" \
    pyenv install 2.7.14

# PYTHON_CONFIGURE_OPTS="--enable-shared" \
#     LDSHARED="clang -undefined dynamic_lookup -bundle"\
#     LDCXXSHARED="clang++ -undefined dynamic_lookup -bundle" \
#     BLDSHARED="clang -bundle -undefined dynamic_lookup -lpython3.6m" \
#     pyenv install 3.6.4
