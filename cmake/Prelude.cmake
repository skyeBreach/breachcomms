# ================================================================================================ #
# Project and Prelude Guards

# Include Guard
include_guard()

# In-Source Build Guard
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
    message(
        FATAL_ERROR
        "In-source builds are not supported."
        "Please read the BUILDING document before trying to build this project."
        "You may need to delete 'CMakeCache.txt' and 'CMakeFiles/' first."
    )
endif()

# Language Standard Guard(s)
if(NOT DEFINED CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 17)
endif()

# ================================================================================================ #

