.section .text.boot, "ax"
.global _start
_start:
  la sp, stack_top

  call kmain
spin:
  j spin

.section .bss
.balign 16
stack0:
  .space 4096 * 4
stack_top:
