.include "cpctelera.h.s"
.include "man/game.h.s"
.include "man/menu.h.s"
.include "man/gameOver.h.s"
.area _DATA
.area _CODE


.globl cpct_disableFirmware_asm


_main::

   call cpct_disableFirmware_asm

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

   


