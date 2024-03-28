load("//:rules.bzl", "in_pkg_srcs")
load("//vendor/github.com/pq-crystals/kyber-11d00ff:rules.bzl", "kyber_cc_library")
load("//platforms/cpu/feature:rules.bzl", "config_compatible_with")

kyber_cc_library(
    name = "consts",
    srcs = ["consts.c"],
    hdrs = [
        "align.h",
        "consts.h",
    ],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
)

kyber_cc_library(
    name = "fq",
    srcs = ["fq.S"],
    hdrs = ["fq.inc"],
    include_prefix = "./",
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [":consts"],
)

kyber_cc_library(
    name = "reduce",
    hdrs = ["reduce.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [":fq"],
)

cc_library(
    name = "fips_headers",
    hdrs = in_pkg_srcs([
        "fips202.h",
        "fips202x4.h",
    ]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    visibility = ["//vendor/github.com/pq-crystals/kyber-11d00ff/avx2/keccak4x:__pkg__"],
)

cc_library(
    name = "fips202",
    srcs = in_pkg_srcs(["fips202.c"]),
    hdrs = in_pkg_srcs(["fips202.h"]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
)

cc_library(
    name = "fips202x4",
    srcs = in_pkg_srcs(["fips202x4.c"]),
    hdrs = in_pkg_srcs(["fips202x4.h"]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":fips202",
        "//vendor/github.com/pq-crystals/kyber-11d00ff/avx2/keccak4x",
    ],
)

alias(
    name = "fips202x4_512",
    actual = ":fips202x4",
)

alias(
    name = "fips202x4_768",
    actual = ":fips202x4",
)

alias(
    name = "fips202x4_1024",
    actual = ":fips202x4",
)

kyber_cc_library(
    name = "invntt",
    srcs = ["invntt.S"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":consts",
        ":fq",
        ":shuffle",
    ],
)

kyber_cc_library(
    name = "basemul",
    srcs = ["basemul.S"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":consts",
        ":fq",
        ":shuffle",
    ],
)

kyber_cc_library(
    name = "shuffle",
    srcs = ["shuffle.S"],
    hdrs = ["shuffle.inc"],
    include_prefix = "./",
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":consts",
        ":fq",
    ],
)

kyber_cc_library(
    name = "ntt",
    srcs = ["ntt.S"],
    hdrs = [
        "fq.inc",
        "ntt.h",
        "shuffle.inc",
    ],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":basemul",
        ":consts",
        ":invntt",
        ":shuffle",
    ],
)

kyber_cc_library(
    name = "cbd",
    srcs = [
        "cbd.c",
        "poly.h",
    ],
    hdrs = ["cbd.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [":consts"],
)

kyber_cc_library(
    name = "symmetric",
    srcs = [
        "fips202.h",
        "fips202x4.h",
        "symmetric-shake.c",
    ],
    hdrs = ["symmetric.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
)

kyber_cc_library(
    name = "poly",
    srcs = ["poly.c"],
    hdrs = ["poly.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":cbd",
        ":ntt",
        ":reduce",
        ":symmetric",
    ],
)

kyber_cc_library(
    name = "polyvec",
    srcs = ["polyvec.c"],
    hdrs = ["polyvec.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [":poly"],
)

kyber_cc_library(
    name = "randombytes",
    srcs = ["randombytes.c"],
    hdrs = ["randombytes.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
)

kyber_cc_library(
    name = "indcpa",
    srcs = ["indcpa.c"],
    hdrs = ["indcpa.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":fips202x4",
        ":polyvec",
        ":randombytes",
        ":rejsample",
    ],
)

kyber_cc_library(
    name = "rejsample",
    srcs = ["rejsample.c"],
    hdrs = ["rejsample.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":consts",
        ":symmetric",
    ],
)

kyber_cc_library(
    name = "verify",
    srcs = ["verify.c"],
    hdrs = ["verify.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
)

kyber_cc_library(
    name = "kem",
    srcs = ["kem.c"],
    hdrs = ["kem.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":indcpa",
        ":verify",
    ],
)

kyber_cc_library(
    name = "kyber",
    hdrs = ["api.h"],
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    visibility = ["//vendor/github.com/pq-crystals/kyber-11d00ff/avx2/test:__pkg__"],
    deps = [
        ":kem",
        ":verify",
    ],
)

cc_library(
    name = "kyber",
    linkstatic = True,
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    visibility = ["//vendor/github.com/pq-crystals/kyber-11d00ff/avx2/test:__pkg__"],
    deps = [
        ":kyber_1024",
        ":kyber_512",
        ":kyber_768",
    ],
)
