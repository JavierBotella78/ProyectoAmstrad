.include "cpctelera.h.s"
.include "interruptions.h.s"

.globl cpct_waitVSYNC_asm


numI::
   .db 6




manIr::

   push af

   ld a, (numI)
   dec a
   jr nz, noZero
      ld a, #6
noZero:
   ld (numI), a

   pop af

   ei
reti

setManIr::
   im 1
   call cpct_waitVSYNC_asm
   halt
   halt
   halt
   call cpct_waitVSYNC_asm
   di
   
   ld a, #0xc3
   ld (0x38), a
   
   ld hl, #manIr
   ld (0x39), hl
   ei
ret