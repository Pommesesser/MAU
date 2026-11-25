const uart = @import("uart.zig");

pub fn putc(c: u8) void {
    uart.putcSync(c);
}

pub fn backspace() void {
    uart.putcSync('\x08');
    uart.putcSync(' ');
    uart.putcSync('\x08');
}

pub fn print(chars: []const u8) void {
    for (chars) |c| {
        putc(c);
    }
}
