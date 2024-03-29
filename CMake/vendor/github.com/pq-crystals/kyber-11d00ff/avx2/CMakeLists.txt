add_kyber_object_with_features(consts "consts.c" "consts.h" "avx2;bmi2")
add_kyber_object_with_features(
  keccak4x "keccak4x/KeccakP-1600-times4-SIMD256.c"
  "keccak4x/KeccakP-1600-times4-SnP.h" "avx2;bmi2")
add_kyber_object_with_features(fq "fq.S" "fq.inc" "avx2;bmi2")
add_kyber_object_with_features(fips202 "fips202.c" "fips202.h" "avx2;bmi2")
add_kyber_object_with_features(fips202x4 "fips202x4.c" "fips202x4.h"
                               "avx2;bmi2")
add_kyber_object_with_features(invntt "invntt.S" "" "avx2;bmi2")
add_kyber_object_with_features(basemul "basemul.S" "" "avx2;bmi2")
add_kyber_object_with_features(shuffle "shuffle.S" "shuffle.inc" "avx2;bmi2")
add_kyber_object_with_features(ntt "ntt.S" "" "avx2;bmi2")
add_kyber_object_with_features(cbd "cbd.c" "cbd.h" "avx2;bmi2")
add_kyber_object_with_features(symmetric "symmetric-shake.c" "symmetric.h"
                               "avx2;bmi2")
add_kyber_object_with_features(poly "poly.c" "poly.h" "avx2;bmi2")
add_kyber_object_with_features(polyvec "polyvec.c" "polyvec.h" "avx2;bmi2")
add_kyber_object_with_features(randombytes "randombytes.c" "randombytes.h"
                               "avx2;bmi2")
add_kyber_object_with_features(indcpa "indcpa.c" "indcpa.h" "avx2;bmi2")
add_kyber_object_with_features(rejsample "rejsample.c" "rejsample.h"
                               "avx2;bmi2")
add_kyber_object_with_features(verify "verify.c" "verify.h" "avx2;bmi2")
add_kyber_object_with_features(kem "kem.c" "kem.h" "avx2;bmi2")

add_kyber_library(
  kyber-avx2
  consts
  fq
  ntt
  fips202
  fips202x4
  invntt
  basemul
  shuffle
  cbd
  symmetric
  poly
  polyvec
  randombytes
  indcpa
  rejsample
  verify
  kem
  keccak4x)

if(BUILD_TESTING)
  add_subdirectory("test")
endif()
