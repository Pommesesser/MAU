const uart = @import("uart.zig");
const console = @import("console.zig");

export fn kmain() void {
    console.print("MAU's Another Unix\n");

    while (true) {
        if (uart.getc()) |c|
            uart.putcSync(c);
    }
}
