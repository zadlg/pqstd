add_dilithium_object_with_features(consts "consts.c" "consts.h" "avx2;bmi2")
add_dilithium_object_with_features(fips202 "fips202.c" "fips202.h" "avx2;bmi2")
add_dilithium_object_with_features(fips202x4 "fips202x4.c" "fips202x4.h"
                                   "avx2;bmi2")
add_dilithium_object_with_features(f1600x4 "f1600x4.S" "" "avx2;bmi2")
add_dilithium_object_with_features(pointwise "pointwise.S" "" "avx2;bmi2")
add_dilithium_object_with_features(invntt "invntt.S" "" "avx2;bmi2")
add_dilithium_object_with_features(ntt "ntt.S" "ntt.h" "avx2;bmi2")
add_dilithium_object_with_features(poly "poly.c" "poly.h" "avx2;bmi2")
add_dilithium_object_with_features(polyvec "polyvec.c" "polyvec.h" "avx2;bmi2")
add_dilithium_object_with_features(randombytes "randombytes.c" "randombytes.h"
                                   "avx2;bmi2")
add_dilithium_object_with_features(rejsample "rejsample.c" "rejsample.h"
                                   "avx2;bmi2")
add_dilithium_object_with_features(rounding "rounding.c" "rounding.h"
                                   "avx2;bmi2")
add_dilithium_object_with_features(sign "sign.c" "sign.h" "avx2;bmi2")
add_dilithium_object_with_features(symmetric "symmetric-shake.c" "symmetric.h"
                                   "avx2;bmi2")
add_dilithium_object_with_features(shuffle "shuffle.S" "shuffle.inc"
                                   "avx2;bmi2")
add_dilithium_object_with_features(packing "packing.c" "packing.inc"
                                   "avx2;bmi2")

add_dilithium_library(
  dilithium-avx2
  consts
  fips202
  fips202x4
  f1600x4
  pointwise
  invntt
  ntt
  poly
  polyvec
  randombytes
  rejsample
  rounding
  sign
  symmetric
  shuffle
  packing)

if(BUILD_TESTING)
  add_subdirectory("test")
endif()
