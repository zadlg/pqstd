def in_srcs(filepaths, root = "@pqstd-srcs//"):
    """Returns paths to files that lie under the pqstd source repository.

      Args:
        filepaths: list[str]
          Filepaths from the root directory.
        root: str
          The pqstd source repository name.

      Returns: list[Label]
          Labels.
    """
    return [Label("{root}:{filepath}".format(root = root, filepath = filepath)) for filepath in filepaths]

def in_pkg_srcs(filepaths, root = "@pqstd-srcs//"):
    """Returns paths to files that lie under the same package as files in
       pqstd source repository.

      Args:
        filepaths: list[str]
          Filepaths from the root directory.
        root: str
          The pqstd source repository name.

      Returns: list[Label]
          Labels.
    """
    package_name = native.package_name()
    return in_srcs(["{package_name}/{filepath}".format(
        package_name = package_name,
        filepath = filepath,
    ) for filepath in filepaths], root)
