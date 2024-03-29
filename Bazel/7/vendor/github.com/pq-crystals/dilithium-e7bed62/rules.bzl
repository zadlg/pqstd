load("//:rules.bzl", "in_pkg_srcs")

"""All supported variants with their corresponding `DILITHIUM_MODE` define."""
_VARIANTS = {
    2: ["DILITHIUM_MODE=2"],
    3: ["DILITHIUM_MODE=3"],
    5: ["DILITHIUM_MODE=5"],
}

def apply_suffix(name, mode):
    """Applies a suffix on `name` depending on `mode`.

      Args:
        name: str
          Name
        mode: int
          Mode

      Returns:
        The name suffixed.
    """
    return "{name}_{mode}".format(
        name = name,
        mode = mode,
    )

def get_dilithium_mode(mode):
    """Returns the right `#define DILITHIUM_MODE` to use depending on the `mode`.

      Args:
        mode: int
          Mode

      Returns:
        The `#define` to use.
    """
    _VARIANTS.get(mode) or fail("Dilithium {mode} is not supported".format(mode = mode))

def dilithium_cc_library(
        name = None,
        srcs = None,
        hdrs = None,
        deps = None,
        *kargs,
        **kwargs):
    """Defines a `cc_library` for each dilithium variant."""
    if srcs:
        srcs += ["params.h", "config.h"]
    for (mode, defines) in _VARIANTS.items():
        native.cc_library(
            name = apply_suffix(name, mode),
            local_defines = defines,
            srcs = in_pkg_srcs(srcs) if srcs else None,
            hdrs = in_pkg_srcs(hdrs) if hdrs else None,
            deps = [apply_suffix(dep, mode) for dep in deps] if deps else None,
            *kargs,
            **kwargs
        )
