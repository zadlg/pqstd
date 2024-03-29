srcs(sourceFiles cpucycles.c)
add_library(kyber-ref-test-cpucycles OBJECT ${sourceFiles})
srcs(sourceFiles speed_print.c)
add_library(kyber-ref-test-speed_print OBJECT ${sourceFiles})

srcs(sourceFiles test_kyber.c)
add_executable(kyber-ref-test ${sourceFiles})
target_link_libraries(kyber-ref-test kyber-512 kyber-768 kyber-1024)
add_test(kyber-ref-test-test kyber-ref-test)

srcs(sourceFiles test_vectors.c)
add_executable(kyber-vectors-ref-test ${sourceFiles})
target_link_libraries(kyber-vectors-ref-test kyber-512 kyber-768 kyber-1024)
add_test(kyber-vectors-ref-test-test kyber-vectors-ref-test)
