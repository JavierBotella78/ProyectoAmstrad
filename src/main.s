.include "cpctelera.h.s"
.include "man/game.h.s"
.area _DATA
.area _CODE


.globl cpct_disableFirmware_asm


_main::

  

   call cpct_disableFirmware_asm

   call manGameInit
   call manGamePlay


   


