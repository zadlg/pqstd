load("//:rules.bzl", "in_pkg_srcs")

cc_library(
    name = "cpucycles",
    srcs = in_pkg_srcs(["cpucycles.c"]),
    hdrs = in_pkg_srcs(["cpucycles.h"]),
)

cc_library(
    name = "speed_print",
    srcs = in_pkg_srcs(["speed_print.c"]),
    hdrs = in_pkg_srcs(["speed_print.h"]),
    deps = [":cpucycles"],
)

cc_test(
    name = "kyber_test",
    size = "small",
    srcs = in_pkg_srcs(["test_kyber.c"]),
    deps = ["//vendor/github.com/pq-crystals/kyber-11d00ff/ref:kyber"],
)

cc_test(
    name = "speed_test",
    size = "small",
    srcs = in_pkg_srcs(["test_speed.c"]),
    deps = [
        ":cpucycles",
        ":speed_print",
        "//vendor/github.com/pq-crystals/kyber-11d00ff/ref:kyber",
    ],
)

cc_test(
    name = "vectors_test",
    size = "large",
    srcs = in_pkg_srcs(["test_vectors.c"]),
    deps = ["//vendor/github.com/pq-crystals/kyber-11d00ff/ref:kyber"],
)
