load("//:rules.bzl", "in_pkg_srcs")
load("//platforms/cpu/feature:rules.bzl", "config_compatible_with")

_AVX2_TARGET = config_compatible_with("//platforms/cpu/feature:avx2_bmi2")

cc_library(
    name = "cpucycles",
    srcs = in_pkg_srcs(["cpucycles.c"]),
    hdrs = in_pkg_srcs(["cpucycles.h"]),
    target_compatible_with = _AVX2_TARGET,
)

cc_library(
    name = "speed_print",
    srcs = in_pkg_srcs(["speed_print.c"]),
    hdrs = in_pkg_srcs(["speed_print.h"]),
    target_compatible_with = _AVX2_TARGET,
    deps = [":cpucycles"],
)

cc_test(
    name = "dilithium_test",
    size = "small",
    srcs = in_pkg_srcs(["test_dilithium.c"]),
    target_compatible_with = _AVX2_TARGET,
    deps = ["//vendor/github.com/pq-crystals/dilithium-e7bed62/avx2:dilithium"],
)

cc_test(
    name = "speed_test",
    size = "small",
    srcs = in_pkg_srcs(["test_speed.c"]),
    target_compatible_with = _AVX2_TARGET,
    deps = [
        ":cpucycles",
        ":speed_print",
        "//vendor/github.com/pq-crystals/dilithium-e7bed62/avx2:dilithium",
    ],
)

cc_test(
    name = "vectors_test",
    size = "large",
    srcs = in_pkg_srcs(["test_vectors.c"]),
    target_compatible_with = _AVX2_TARGET,
    deps = ["//vendor/github.com/pq-crystals/dilithium-e7bed62/avx2:dilithium"],
)

cc_test(
    name = "mul_test",
    srcs = in_pkg_srcs(["test_mul.c"]),
    target_compatible_with = _AVX2_TARGET,
    deps = ["//vendor/github.com/pq-crystals/dilithium-e7bed62/avx2:dilithium"],
)
