add_dilithium_object(ntt "ntt.c" "ntt.h")
add_dilithium_object(packing "packing.c" "packing.h")
add_dilithium_object(fips202 "fips202.c" "fips202.h")
add_dilithium_object(poly "poly.c" "poly.h")
add_dilithium_object(polyvec "polyvec.c" "polyvec.h")
add_dilithium_object(rounding "rounding.c" "rounding.h")
add_dilithium_object(randombytes "randombytes.c" "randombytes.h")
add_dilithium_object(reduce "reduce.c" "reduce.h")
add_dilithium_object(sign "sign.c" "sign.h")
add_dilithium_object(symmetric "symmetric-shake.c" "symmetric.h")

add_dilithium_library(
  dilithium
  reduce
  ntt
  fips202
  symmetric
  poly
  polyvec
  randombytes
  sign
  rounding
  packing)

if(BUILD_TESTING)
  add_subdirectory("test")
endif()
