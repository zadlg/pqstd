load("@bazel_skylib//lib:selects.bzl", "selects")

selects.config_setting_group(
    name = "avx2_bmi2",
    match_all = [
        "//platforms/cpu/feature/avx2:has_avx2",
        "//platforms/cpu/feature/bmi2:has_bmi2",
    ],
    visibility = ["//visibility:public"],
)
