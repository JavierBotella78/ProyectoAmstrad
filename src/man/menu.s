.include "cpctelera.h.s"

.include "menu.h.s"
.include "entity.h.s"
.include "interruptions.h.s"

.include "../sys/render.h.s"
.include "../sys/prerender.h.s"
.include "../sys/colisions.h.s"
.include "../sys/input.h.s"
.include "../sys/physics.h.s"
.include "../sys/ai.h.s"
.include "../sys/generator.h.s"
.include "../sys/animations.h.s"

.globl cpct_scanKeyboard_asm
.globl cpct_isKeyPressed_asm

menuCoin:
    .db #0

boolMenuLoop:
    .db #0


manMenuInit::

    ld a, #0
    ld (#boolMenuLoop), a

    ld a, #0
    ld (#menuCoin), a

    call manEntityInit ;; Iniciamos todos los valores del array a 0
    call sysRenderInit 
    call sysGeneratorInitMenu
    call setManIr
    call sysPreRenderUpdate

ret



manMenuLoop::

    call manMenuCheckInput

    ld a, (#boolMenuLoop)
    or a
    
    jp z, manMenuLoop
ret



manMenuCheckInput:

    call cpct_scanKeyboard_asm

    ld hl, #Key_C
    call cpct_isKeyPressed_asm

    jr nz, cMenuPulsada

    ld hl, #Key_Space
    call cpct_isKeyPressed_asm

    jr nz, enterMenuPulsada

    ret

cMenuPulsada:

    ld a, (#menuCoin)
    or a
    
    ret nz

    inc a
    ld (#menuCoin), a

    ret

enterMenuPulsada:

    ld a, (#menuCoin)
    or a
    
    ret z

    ld a, (#menuCoin)
    dec a
    ld (menuCoin), a

    ld a, #1
    ld (boolMenuLoop), a

ret
