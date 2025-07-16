[![CI](https://github.com/allyourcodebase/bzip2/actions/workflows/ci.yaml/badge.svg)](https://github.com/allyourcodebase/bzip2/actions)

# bzip2

This is [bzip2](ttps://github.com/libarchive/bzip2), packaged for [Zig](https://ziglang.org/).

## Installation

First, update your `build.zig.zon`:

```
# Initialize a `zig build` project if you haven't already
zig init
zig fetch --save git+https://github.com/allyourcodebase/bzip2.git#1.0.8
```

You can then import `bzip` in your `build.zig` with:

```zig
const bzip_dependency = b.dependency("bzip", .{
    .target = target,
    .optimize = optimize,
});
your_exe.linkLibrary(bzip_dependency.artifact("bz"));
```

