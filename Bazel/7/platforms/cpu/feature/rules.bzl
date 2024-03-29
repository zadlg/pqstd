def config_compatible_with(c):
    return select({
        c: [],
        "//conditions:default": ["@platforms//:incompatible"],
    })
