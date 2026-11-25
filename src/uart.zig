const base: *volatile [8]u8 = @ptrFromInt(0x1000_0000);

const ReadReg = enum(u3) {
    rhr = 0, // receive holding register
    ier = 1, // interrupt enable register
    isr = 2, // interrupt status register
    lcr = 3, // line control register
    mcr = 4, // unused
    lsr = 5, // line status register
    msr = 6, // unused
    scr = 7, // unused
};

const WriteReg = enum(u3) {
    thr = 0, // transmit holding register
    ier = 1, // interrupt enable register
    fcr = 2, // FIFO control register
    lcr = 3, // line control register
    mcr = 4, // unused
    scr = 7, // unused
};

// these are masks for now
// probably replace with function per mask
fn thrCanAccept() bool {
    return (read(.lsr) & (1 << 5)) != 0;
}

fn read(r: ReadReg) u8 {
    return base[@backingInt(r)];
}

fn write(r: WriteReg, value: u8) void {
    base[@backingInt(r)] = value;
}

pub fn putcSync(c: u8) void {
    while (!thrCanAccept()) {}
    write(.thr, c);
}
