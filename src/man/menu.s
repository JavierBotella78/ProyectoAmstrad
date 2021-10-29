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

controlsTimer:
    .dw #20000

blinkMenuTimer:
    .dw #0

boolMenuBlink:
    .db #1

manMenuInit::

    ld a, #0
    ld (#boolMenuLoop), a

    ld a, #0
    ld (#menuCoin), a

    ld hl, #20000
    ld (#controlsTimer), hl

    ld hl, #4000
    ld (#blinkMenuTimer), hl

    ld a, #1
    ld (#boolMenuBlink), a

    call sysRenderInit 
    call sysRenderInitMenu
    call sysGeneratorInitMenu

ret



manMenuLoop::

    call manMenuCheckInput
    call manMenuCheckBlink

    ld a, (#boolMenuLoop)
    or a
    
    jp z, manMenuLoop

    ld a, #0
    ld (boolMenuLoop), a

    call sysGeneratorInitMenu2

manMenuLoop2:

    call manMenuCheckInput2

    ld hl, (#controlsTimer)
    dec hl
    ld (controlsTimer), hl

    ld a, h
    or a

    jp nz, skipControlTimer

    ld a, l
    or a

    jp nz, skipControlTimer

    ld a, #1
    ld (boolMenuLoop), a

skipControlTimer:

    ld a, (#boolMenuLoop)
    or a

    jp z, manMenuLoop2

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

    call sysGeneratorInitMenuCredit

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



manMenuCheckInput2:

    call cpct_scanKeyboard_asm

    ld hl, #Key_P
    call cpct_isKeyPressed_asm

    jr nz, pMenuPulsada

    ret

pMenuPulsada:

    ld a, #1
    ld (boolMenuLoop), a

ret



manMenuCheckBlink:

    ld hl, (#blinkMenuTimer)
    dec hl
    ld (blinkMenuTimer), hl

    ld a, h
    or a

    ret nz

    ld a, l
    or a

    ret nz

    ld a, (#boolMenuBlink)
    or a

    jp z, blinkMenuDraw

    ld hl, #2000
    ld (blinkMenuTimer), hl

    ld a, #0
    ld (boolMenuBlink), a

    call sysGeneratorMenuErase

    ret

blinkMenuDraw:

    ld hl, #4000
    ld (blinkMenuTimer), hl


    ld a, #1
    ld (boolMenuBlink), a

    ld a, (#menuCoin)
    or a

    jp z, blinkMenuDrawInsert

    call sysGeneratorMenuSpace

    ret

blinkMenuDrawInsert:

    call sysGeneratorMenuInsertCoin

ret