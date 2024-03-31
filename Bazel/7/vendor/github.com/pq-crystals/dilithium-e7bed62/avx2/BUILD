load("//:rules.bzl", "in_pkg_srcs")
load("//vendor/github.com/pq-crystals/dilithium-e7bed62:rules.bzl", "dilithium_cc_library")
load("//platforms/cpu/feature:rules.bzl", "config_compatible_with")

_AVX2_TARGET = config_compatible_with("//platforms/cpu/feature:avx2_bmi2")

dilithium_cc_library(
    name = "align",
    hdrs = ["align.h"],
    target_compatible_with = _AVX2_TARGET,
)

dilithium_cc_library(
    name = "consts",
    srcs = ["consts.c"],
    hdrs = ["consts.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [":align"],
)

dilithium_cc_library(
    name = "shuffle",
    srcs = ["shuffle.S"],
    hdrs = ["shuffle.inc"],
    include_prefix = "./",
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":consts",
    ],
)

dilithium_cc_library(
    name = "invntt",
    srcs = ["invntt.S"],
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":consts",
        ":shuffle",
    ],
)

cc_library(
    name = "fips202",
    srcs = in_pkg_srcs(["fips202.c"]),
    hdrs = in_pkg_srcs(["fips202.h"]),
    target_compatible_with = _AVX2_TARGET,
)

cc_library(
    name = "f1600x4",
    srcs = in_pkg_srcs([
        "f1600x4.S",
        "fips202x4.h",
    ]),
    target_compatible_with = _AVX2_TARGET,
)

cc_library(
    name = "fips202x4",
    srcs = in_pkg_srcs(["fips202x4.c"]),
    hdrs = in_pkg_srcs(["fips202x4.h"]),
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":f1600x4",
        ":fips202",
    ],
)

alias(
    name = "fips202x4_2",
    actual = ":fips202x4",
)

alias(
    name = "fips202x4_3",
    actual = ":fips202x4",
)

alias(
    name = "fips202x4_5",
    actual = ":fips202x4",
)

dilithium_cc_library(
    name = "symmetric",
    srcs = ["symmetric-shake.c"],
    hdrs = ["symmetric.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [":fips202x4"],
)

dilithium_cc_library(
    name = "ntt",
    srcs = ["ntt.S"],
    hdrs = ["ntt.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":consts",
        ":invntt",
        ":shuffle",
    ],
)

dilithium_cc_library(
    name = "rejsample",
    srcs = ["rejsample.c"],
    hdrs = ["rejsample.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [":symmetric"],
)

dilithium_cc_library(
    name = "randombytes",
    srcs = ["randombytes.c"],
    hdrs = ["randombytes.h"],
    target_compatible_with = _AVX2_TARGET,
)

dilithium_cc_library(
    name = "pointwise",
    srcs = ["pointwise.S"],
    target_compatible_with = _AVX2_TARGET,
    deps = [":consts"],
)

dilithium_cc_library(
    name = "packing",
    srcs = ["packing.c"],
    hdrs = ["packing.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [":polyvec"],
)

dilithium_cc_library(
    name = "rounding",
    srcs = ["rounding.c"],
    hdrs = ["rounding.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":consts",
        ":rejsample",
    ],
)

dilithium_cc_library(
    name = "poly",
    srcs = ["poly.c"],
    hdrs = ["poly.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":align",
        ":ntt",
        ":pointwise",
        ":rounding",
        ":symmetric",
    ],
)

dilithium_cc_library(
    name = "polyvec",
    srcs = ["polyvec.c"],
    hdrs = ["polyvec.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [":poly"],
)

dilithium_cc_library(
    name = "sign",
    srcs = ["sign.c"],
    hdrs = ["sign.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":align",
        ":packing",
        ":polyvec",
        ":randombytes",
    ],
)

dilithium_cc_library(
    name = "dilithium",
    hdrs = ["api.h"],
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":sign",
    ],
)

cc_library(
    name = "dilithium",
    hdrs = in_pkg_srcs(["api.h"]),
    target_compatible_with = _AVX2_TARGET,
    visibility = ["//visibility:public"],
    deps = [
        ":dilithium_2",
        ":dilithium_3",
        ":dilithium_5",
    ],
)
