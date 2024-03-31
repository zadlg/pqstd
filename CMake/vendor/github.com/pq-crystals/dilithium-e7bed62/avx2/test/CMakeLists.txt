if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
  srcs(sourceFiles cpucycles.c)
  add_library(dilithium-avx2-test-cpucycles OBJECT ${sourceFiles})
  srcs(sourceFiles speed_print.c)
  add_library(dilithium-avx2-test-speed_print OBJECT ${sourceFiles})
endif()

srcs(sourceFiles test_dilithium.c)
add_executable(dilithium-avx2-test ${sourceFiles})
target_link_libraries(dilithium-avx2-test dilithium-avx2-2 dilithium-avx2-3
                      dilithium-avx2-5)
add_test(dilithium-avx2-test-test dilithium-avx2-test)

srcs(sourceFiles test_vectors.c)
add_executable(dilithium-vectors-avx2-test ${sourceFiles})
target_link_libraries(dilithium-vectors-avx2-test dilithium-avx2-2
                      dilithium-avx2-3 dilithium-avx2-5)
add_test(dilithium-vectors-avx2-test-test dilithium-vectors-avx2-test)

srcs(sourceFiles test_mul.c)
add_executable(dilithium-mul-avx2-test ${sourceFiles})
target_link_libraries(dilithium-mul-avx2-test dilithium-avx2-2 dilithium-avx2-3
                      dilithium-avx2-5)
add_test(dilithium-mul-avx2-test-test dilithium-mul-avx2-test)
