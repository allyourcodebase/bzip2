const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("upstream", .{});

    const bz2_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
    });
    bz2_mod.link_libc = true;

    bz2_mod.addCSourceFiles(.{
        .root = upstream.path("."),
        .files = &.{
            "blocksort.c",
            "huffman.c",
            "crctable.c",
            "randtable.c",
            "compress.c",
            "decompress.c",
            "bzlib.c",
        },
    });

    const bz = b.addLibrary(.{
        .linkage = .static,
        .name = "bz",
        .root_module = bz2_mod,
    });
    bz.installHeader(upstream.path("bzlib.h"), "bzlib.h");

    b.installArtifact(bz);

    const bzip2_mod = b.createModule(.{
        .target = target,
        .optimize = optimize,
    });
    bzip2_mod.link_libc = true;
    bzip2_mod.addCSourceFile(.{ .file = upstream.path("bzip2.c") });
    bzip2_mod.linkLibrary(bz);

    const bzip2_exe = b.addExecutable(.{
        .name = "bzip2",
        .root_module = bzip2_mod,
    });
    b.installArtifact(bzip2_exe);
}
