cmake_minimum_required(VERSION 3.12...3.29)

if(CMAKE_CURRENT_BINARY_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  message(FATAL_ERROR "cannot build in-source.")
  return()
endif()

project(
  pqstd
  VERSION 0.1
  LANGUAGES ASM C)

include(CTest)

get_filename_component(PQSTD_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}" DIRECTORY
                       CACHE)
message(STATUS "Using sources at ${PQSTD_SOURCE_DIR}")

include(CheckCCompilerFlag)
set(CMAKE_REQUIRED_FLAGS "-Wno-unused-argument -Werror")
check_c_compiler_flag("-mavx2" avx2Supported)
check_c_compiler_flag("-mbmi2" bmi2Supported)
set(PQSTD_AVX2_SUPPORTED FALSE)
if(avx2Supported AND bmi2Supported)
  message(STATUS "enable avx2 variants")
  set(PQSTD_AVX2_SUPPORTED TRUE)
endif()

function(srcs var)
  file(RELATIVE_PATH base "${CMAKE_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}")
  set(list "")
  foreach(s ${ARGN})
    list(APPEND list "${PQSTD_SOURCE_DIR}/${base}/${s}")
  endforeach()
  set(${var}
      "${list}"
      PARENT_SCOPE)
endfunction()

enable_testing()
add_subdirectory("vendor/github.com/pq-crystals/kyber-11d00ff")
add_subdirectory("vendor/github.com/pq-crystals/dilithium-e7bed62")
