const uart: [*]volatile u8 = @ptrFromInt(0x1000_0000);

const thr: u8 = 0;
const lsr: u8 = 5;

const lsr_tx_idle: u8 = 1 << 5;

pub fn putcSync(c: u8) void {
    while ((uart[lsr] & lsr_tx_idle) == 0) {}
    uart[thr] = c;
}
