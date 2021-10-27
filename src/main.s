.include "cpctelera.h.s"
.include "man/game.h.s"
.include "man/menu.h.s"
.include "man/interruptions.h.s"
.include "man/gameOver.h.s"
.include "cancion1.h.s"
.area _DATA
.area _CODE


.globl cpct_disableFirmware_asm

.globl cpct_akp_musicInit_asm


_main::

   call cpct_disableFirmware_asm

   call setManIr

   ld de, #_cancion1
   call cpct_akp_musicInit_asm

hardReset:
   call manMenuInit
   call manMenuLoop

softReset:
   call manGameInit
   call manGamePlay

   ld hl, #softReset
   call manGameOverInit
   call manGameOverLoop

jp hardReset

   


