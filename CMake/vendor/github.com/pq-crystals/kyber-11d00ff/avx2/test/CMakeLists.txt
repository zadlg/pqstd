srcs(sourceFiles cpucycles.c)
add_library(kyber-avx2-test-cpucycles OBJECT ${sourceFiles})
srcs(sourceFiles speed_print.c)
add_library(kyber-avx2-test-speed_print OBJECT ${sourceFiles})

srcs(sourceFiles test_kyber.c)
add_executable(kyber-avx2-test ${sourceFiles})
target_link_libraries(kyber-avx2-test kyber-avx2-512 kyber-avx2-768
                      kyber-avx2-1024)
add_test(kyber-avx2-test-test kyber-avx2-test)

srcs(sourceFiles test_vectors.c)
add_executable(kyber-vectors-avx2-test ${sourceFiles})
target_link_libraries(kyber-vectors-avx2-test kyber-avx2-512 kyber-avx2-768
                      kyber-avx2-1024)
add_test(kyber-vectors-avx2-test-test kyber-vectors-avx2-test)
