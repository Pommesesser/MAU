pub extern fn readScause() u64;

pub extern fn writeStvec(addr: u64) void;

pub extern fn readSepc() u64;
pub extern fn writeSepc(addr: u64) void;

pub extern fn readStval() u64;

pub extern fn readSstatus() u64;
pub extern fn writeSstatus(bits: u64) void;

pub extern fn readSie() u64;
pub extern fn writeSie(bits: u64) void;

pub extern fn readTime() u64;
pub extern fn writeStimecmp(deadline: u64) void;

pub extern fn intrOn() void;
pub extern fn intrOff() void;
