# CUSTOM output executable and lib files
DEFAULT_TARGET :=		debug
TARGET_EXEC :=			test_db
TARGET_LIB :=
HEADER_EXT :=			.hpp
SOURCE_EXT :=			.cpp

# CUSTOM paths
INC_DIRS :=
INC_EXT_DIRS :=			ext/soci/include/soci ext/soci/include/soci/postgresql /usr/include/postgresql
FORMAT_INC_DIRS :=
SRC_DIRS :=
TEST_SRC_DIRS :=
FORMAT_SRC_DIRS :=		src
MAIN_SRC :=			src/main.cpp
LIB_DIRS :=			ext/soci/lib64
ROOT_BUILD_DIR :=		bin

# CUSTOM libs for different targets
RELEASE_LIBS :=			soci_core soci_postgresql dl pq
STATIC_LIBS :=			$(RELEASE_LIBS)
LIBRARY_LIBS :=			$(RELEASE_LIBS)
DEBUG_LIBS :=			$(RELEASE_LIBS)
PROFILE_LIBS :=			$(RELEASE_LIBS)
TEST_LIBS :=			$(RELEASE_LIBS)

# finally, include the generic makefile
include ext/Makefile.inc
