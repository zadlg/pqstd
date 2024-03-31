load("//vendor/github.com/pq-crystals/dilithium-e7bed62:rules.bzl", "dilithium_cc_library")

dilithium_cc_library(
    name = "reduce",
    srcs = ["reduce.c"],
    hdrs = ["reduce.h"],
)

dilithium_cc_library(
    name = "fips202",
    srcs = ["fips202.c"],
    hdrs = ["fips202.h"],
)

dilithium_cc_library(
    name = "ntt",
    srcs = ["ntt.c"],
    hdrs = ["ntt.h"],
    deps = [":reduce"],
)

dilithium_cc_library(
    name = "rounding",
    srcs = ["rounding.c"],
    hdrs = ["rounding.h"],
)

dilithium_cc_library(
    name = "symmetric",
    srcs = ["symmetric-shake.c"],
    hdrs = ["symmetric.h"],
    deps = [":fips202"],
)

dilithium_cc_library(
    name = "poly",
    srcs = ["poly.c"],
    hdrs = ["poly.h"],
    deps = [
        ":ntt",
        ":rounding",
        ":symmetric",
    ],
)

dilithium_cc_library(
    name = "polyvec",
    srcs = ["polyvec.c"],
    hdrs = ["polyvec.h"],
    deps = [":poly"],
)

dilithium_cc_library(
    name = "packing",
    srcs = ["packing.c"],
    hdrs = ["packing.h"],
    deps = [":polyvec"],
)

dilithium_cc_library(
    name = "randombytes",
    srcs = ["randombytes.c"],
    hdrs = ["randombytes.h"],
)

dilithium_cc_library(
    name = "sign",
    srcs = ["sign.c"],
    hdrs = ["sign.h"],
    deps = [
        ":packing",
        ":polyvec",
        ":randombytes",
    ],
)

dilithium_cc_library(
    name = "dilithium",
    hdrs = ["api.h"],
    deps = [
        ":sign",
    ],
)

cc_library(
    name = "dilithium",
    visibility = ["//visibility:public"],
    deps = [
        ":dilithium_2",
        ":dilithium_3",
        ":dilithium_5",
    ],
)
