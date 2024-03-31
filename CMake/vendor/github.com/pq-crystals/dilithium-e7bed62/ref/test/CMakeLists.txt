if(CMAKE_SYSTEM_PROCESSOR STREQUAL "x86_64")
  srcs(sourceFiles cpucycles.c)
  add_library(dilithium-ref-test-cpucycles OBJECT ${sourceFiles})
  srcs(sourceFiles speed_print.c)
  add_library(dilithium-ref-test-speed_print OBJECT ${sourceFiles})
endif()

srcs(sourceFiles test_dilithium.c)
add_executable(dilithium-ref-test ${sourceFiles})
target_link_libraries(dilithium-ref-test dilithium-2 dilithium-3 dilithium-5)
add_test(dilithium-ref-test-test dilithium-ref-test)

srcs(sourceFiles test_vectors.c)
add_executable(dilithium-vectors-ref-test ${sourceFiles})
target_link_libraries(dilithium-vectors-ref-test dilithium-2 dilithium-3
                      dilithium-5)
add_test(dilithium-vectors-ref-test-test dilithium-vectors-ref-test)

srcs(sourceFiles test_mul.c)
add_executable(dilithium-mul-ref-test ${sourceFiles})
target_link_libraries(dilithium-mul-ref-test dilithium-2 dilithium-3
                      dilithium-5)
add_test(dilithium-mul-ref-test-test dilithium-mul-ref-test)
