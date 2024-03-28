load("//:rules.bzl", s = "in_pkg_srcs")

cc_library(
    name = "align",
    hdrs = s(["KeccakP-align.h"]),
)

cc_library(
    name = "config",
    hdrs = s(["KeccakP-SIMD256-config.h"]),
)

cc_library(
    name = "brg_endian",
    hdrs = s(["KeccakP-brg_endian.h"]),
)

cc_library(
    name = "keccak4x",
    srcs = s(["KeccakP-1600-times4-SIMD256.c"]),
    hdrs = s(["KeccakP-1600-times4-SnP.h"]),
    additional_compiler_inputs = s(["KeccakP-1600-unrolling.macros"]),
    visibility = ["//vendor/github.com/pq-crystals/kyber-11d00ff/avx2:__pkg__"],
    deps = [
        ":align",
        ":brg_endian",
        ":config",
        "//vendor/github.com/pq-crystals/kyber-11d00ff/avx2:fips_headers",
    ],
)
