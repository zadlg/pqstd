add_kyber_object(reduce "reduce.c" "reduce.h")
add_kyber_object(ntt "ntt.c" "ntt.h")
add_kyber_object(cbd "cbd.c" "cbd.h")
add_kyber_object(fips202 "fips202.c" "fips202.h")
add_kyber_object(symmetric "symmetric-shake.c" "symmetric.h")
add_kyber_object(poly "poly.c" "poly.h")
add_kyber_object(polyvec "polyvec.c" "polyvec.h")
add_kyber_object(randombytes "randombytes.c" "randombytes.h")
add_kyber_object(indcpa "indcpa.c" "indcpa.h")
add_kyber_object(verify "verify.c" "verify.h")
add_kyber_object(kem "kem.c" "kem.h")

add_kyber_library(
  kyber
  reduce
  ntt
  cbd
  fips202
  symmetric
  poly
  polyvec
  randombytes
  indcpa
  verify
  kem)

if(BUILD_TESTING)
  add_subdirectory("test")
endif()
