.include "cpctelera.h.s"

.globl cpct_waitVSYNC_asm

.globl sysPhysicsUpdate
.globl sysRenderUpdate
.globl sysGeneratorUpdate

.globl manEntityInit 
.globl sysRenderInit 

manGameInit:

call manEntityInit ;; Iniciamos todos los valores del array a 0
call sysRenderInit 

ret

manGamePlay:

mainLoop:
   call sysPhysicsUpdate
   call sysGeneratorUpdate
   call sysRenderUpdate
   
   call esperar


loop:
   jr    mainLoop
   
ret


esperar:
   ld a, #3
   esperarbucle:
   push af
   halt
   halt
   call cpct_waitVSYNC_asm
   pop af
   dec a
   jr nz, esperarbucle
ret