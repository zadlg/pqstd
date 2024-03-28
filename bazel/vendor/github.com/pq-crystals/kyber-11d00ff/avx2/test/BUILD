load("//platforms/cpu/feature:rules.bzl", "config_compatible_with")
load("//:rules.bzl", "in_pkg_srcs")

cc_library(
    name = "cpucycles",
    srcs = in_pkg_srcs(["cpucycles.c"]),
    hdrs = in_pkg_srcs(["cpucycles.h"]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
)

cc_library(
    name = "speed_print",
    srcs = in_pkg_srcs(["speed_print.c"]),
    hdrs = in_pkg_srcs(["speed_print.h"]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [":cpucycles"],
)

cc_test(
    name = "kyber_test",
    size = "small",
    srcs = in_pkg_srcs(["test_kyber.c"]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = ["//vendor/github.com/pq-crystals/kyber-11d00ff/avx2:kyber"],
)

cc_test(
    name = "speed_test",
    size = "small",
    srcs = in_pkg_srcs(["test_speed.c"]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = [
        ":cpucycles",
        ":speed_print",
        "//vendor/github.com/pq-crystals/kyber-11d00ff/avx2:kyber",
    ],
)

cc_test(
    name = "vectors_test",
    size = "large",
    srcs = in_pkg_srcs(["test_vectors.c"]),
    target_compatible_with = config_compatible_with("//platforms/cpu/feature:avx2_bmi2"),
    deps = ["//vendor/github.com/pq-crystals/kyber-11d00ff/avx2:kyber"],
)
