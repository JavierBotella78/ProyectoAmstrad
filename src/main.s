.include "cpctelera.h.s"
.include "man/game.h.s"
.include "man/menu.h.s"
.area _DATA
.area _CODE


.globl cpct_disableFirmware_asm


_main::

   call cpct_disableFirmware_asm

   call manMenuInit
   call manMenuLoop

   call manGameInit
   call manGamePlay


   


