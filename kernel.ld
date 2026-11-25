/* Where everything in the kernel image goes in memory. */
ENTRY(_start)

SECTIONS
{
    /* On QEMU "virt", RAM starts at 0x80000000. The OpenSBI firmware
       occupies the start of it and jumps to 0x80200000: that's us. */
    . = 0x80200000;

    .text : ALIGN(4K)
    {
        KEEP(*(.text.boot))   /* the entry point goes first */
        *(.text .text.*)
    }

    .rodata : ALIGN(4K) { *(.srodata .srodata.*) *(.rodata .rodata.*) }
    .data   : ALIGN(4K) { *(.sdata .sdata.*) *(.data .data.*) }
    .bss    : ALIGN(4K) { *(.sbss .sbss.*) *(.bss .bss.*) *(COMMON) }
}
