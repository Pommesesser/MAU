.section .text

.global readScause
readScause:
  csrr a0, scause
  ret

.global writeStvec
writeStvec:
  csrw stvec, a0
  ret

.global readSepc
readSepc:
  csrr a0, sepc
  ret

.global writeSepc
writeSepc:
  csrw sepc, a0
  ret

.global readStval
readStval:
  csrr a0, stval
  ret

.global readSstatus
readSstatus:
  csrr a0, sstatus
  ret

.global writeSstatus
writeSstatus:
  csrw sstatus, a0
  ret

.global readSie
readSie:
  csrr a0, sie
  ret

.global writeSie
writeSie:
  csrw sie, a0
  ret

.global readTime
readTime:
  csrr a0, time
  ret

.global writeStimecmp
writeStimecmp:
  csrw stimecmp, a0
  ret

.global intrOn
intrOn:
  csrsi sstatus, 2
  ret

.global intrOff
intrOff:
  csrci sstatus, 2
  ret
