const base: *volatile [8]u8 = @ptrFromInt(0x1000_0000);

const Reg = enum(u3) {
    thr = 0,
    ier = 1,
    fcr = 2,
    lcr = 3,
    mcr = 4,
    lsr = 5,
    msr = 6,
    scr = 7,
};

const lsr_tx_idle: u8 = 1 << 5;

fn read(r: Reg) u8 {
    return base[@backingInt(r)];
}

fn write(r: Reg, value: u8) void {
    base[@backingInt(r)] = value;
}

pub fn putcSync(c: u8) void {
    while ((read(.lsr) & lsr_tx_idle) == 0) {}
    write(.thr, c);
}
