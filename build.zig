const std = @import("std");

pub fn build(b: *std.Build) void {
    // Bare-metal 64-bit RISC-V: no OS underneath us, no C library.
    const riscv = std.Target.riscv;
    const target = b.resolveTargetQuery(.{
        .cpu_arch = .riscv64,
        .os_tag = .freestanding,
        .abi = .none,
        // RV64 + Multiply, Atomics, Compressed instructions, and the CSR
        // instructions a kernel needs. Deliberately NO floating point (f/d):
        // the FPU is off until we turn it on, so the compiler mustn't use it.
        .cpu_model = .{ .explicit = &riscv.cpu.generic_rv64 },
        .cpu_features_add = riscv.featureSet(&.{ .m, .a, .c, .zicsr, .zifencei }),
    });
    const optimize = b.standardOptimizeOption(.{});

    const kernel_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        // Our code lives at 0x80200000, above 2 GiB. "medany" lets the
        // compiler address code/data anywhere, not just near address 0.
        .code_model = .medany,
    });
    kernel_mod.addAssemblyFile(b.path("src/start.S"));
    kernel_mod.addAssemblyFile(b.path("src/csr.S"));

    const kernel = b.addExecutable(.{
        .name = "mau.elf",
        .root_module = kernel_mod,
    });
    kernel.setLinkerScript(b.path("kernel.ld"));
    b.installArtifact(kernel); // -> zig-out/bin/mau.elf

    // `zig build run` boots the kernel in QEMU. Quit with Ctrl-A then X.
    const qemu = b.addSystemCommand(&.{
        "qemu-system-riscv64",
        "-machine", "virt", // QEMU's simple generic RISC-V board
        "-bios", "default", // OpenSBI firmware, starts us in S-mode
        "-nographic", // serial port <-> this terminal, no window
        "-no-reboot",
        "-kernel",
    });
    qemu.addArtifactArg(kernel);
    qemu.addPassthruArgs(); // zig build run -- -s -S
    qemu.step.dependOn(b.getInstallStep());

    const run_step = b.step("run", "Boot the kernel in QEMU");
    run_step.dependOn(&qemu.step);
}
