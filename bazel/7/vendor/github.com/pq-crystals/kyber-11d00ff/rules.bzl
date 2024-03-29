load("//:rules.bzl", "in_pkg_srcs")

"""All supported variants with their corresponding `KYBER_K` define."""
_VARIANTS = {
    512: ["KYBER_K=2"],
    768: ["KYBER_K=3"],
    1024: ["KYBER_K=4"],
}

def apply_suffix(name, sbits):
    """Applies a suffix on `name` depending on `sbits`.

      Args:
        name: str
          Name
        sbits: int
          Security bits

      Returns:
        The name suffixed.
    """
    return "{name}_{sbits}".format(
        name = name,
        sbits = sbits,
    )

def get_kyber_k(sbits):
    """Returns the right `#define KYBER_K` to use depending on the `sbits`.

      Args:
        sbits: int
          Security bits

      Returns:
        The `#define` to use.
    """
    _VARIANTS.get(sbits) or fail("Kyber {sbits} is not supported".format(sbits))

def kyber_cc_library(
        name = None,
        srcs = None,
        hdrs = None,
        deps = None,
        *kargs,
        **kwargs):
    """Defines a `cc_library` for each kyber variant."""
    if srcs:
        srcs.append("params.h")
    for (sbits, defines) in _VARIANTS.items():
        native.cc_library(
            name = apply_suffix(name, sbits),
            local_defines = defines,
            srcs = in_pkg_srcs(srcs) if srcs else None,
            hdrs = in_pkg_srcs(hdrs) if hdrs else None,
            deps = [apply_suffix(dep, sbits) for dep in deps] if deps else None,
            *kargs,
            **kwargs
        )
