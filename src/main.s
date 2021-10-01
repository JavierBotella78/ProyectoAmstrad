.include "cpctelera.h.s"
.area _DATA
.area _CODE


.globl cpct_disableFirmware_asm

.globl manGameInit
.globl manGamePlay


_main::

   call cpct_disableFirmware_asm

   call manGameInit
   call manGamePlay


   


