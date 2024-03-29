load("//vendor/github.com/pq-crystals/kyber-11d00ff:rules.bzl", "kyber_cc_library")

kyber_cc_library(
    name = "reduce",
    srcs = ["reduce.c"],
    hdrs = ["reduce.h"],
)

kyber_cc_library(
    name = "ntt",
    srcs = ["ntt.c"],
    hdrs = ["ntt.h"],
    deps = [":reduce"],
)

kyber_cc_library(
    name = "cbd",
    srcs = [
        "cbd.c",
        "poly.h",
    ],
    hdrs = ["cbd.h"],
)

kyber_cc_library(
    name = "fips202",
    srcs = ["fips202.c"],
    hdrs = ["fips202.h"],
)

kyber_cc_library(
    name = "symmetric",
    srcs = ["symmetric-shake.c"],
    hdrs = ["symmetric.h"],
    deps = [
        ":cbd",
        ":fips202",
        ":ntt",
    ],
)

kyber_cc_library(
    name = "poly",
    srcs = ["poly.c"],
    hdrs = ["poly.h"],
    deps = [
        ":cbd",
        ":ntt",
        ":symmetric",
    ],
)

kyber_cc_library(
    name = "polyvec",
    srcs = ["polyvec.c"],
    hdrs = ["polyvec.h"],
    deps = [":poly"],
)

kyber_cc_library(
    name = "randombytes",
    srcs = ["randombytes.c"],
    hdrs = ["randombytes.h"],
)

kyber_cc_library(
    name = "indcpa",
    srcs = ["indcpa.c"],
    hdrs = ["indcpa.h"],
    deps = [
        ":polyvec",
        ":randombytes",
    ],
)

kyber_cc_library(
    name = "verify",
    srcs = ["verify.c"],
    hdrs = ["verify.h"],
)

kyber_cc_library(
    name = "kem",
    srcs = ["kem.c"],
    hdrs = ["kem.h"],
    deps = [
        ":indcpa",
        ":verify",
    ],
)

kyber_cc_library(
    name = "kyber",
    hdrs = ["api.h"],
    visibility = ["//vendor/github.com/pq-crystals/kyber-11d00ff/ref/test:__pkg__"],
    deps = [
        ":kem",
        ":verify",
    ],
)

cc_library(
    name = "kyber",
    linkstatic = True,
    visibility = ["//vendor/github.com/pq-crystals/kyber-11d00ff/ref/test:__pkg__"],
    deps = [
        ":kyber_1024",
        ":kyber_512",
        ":kyber_768",
    ],
)
