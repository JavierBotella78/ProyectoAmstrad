.include "cpctelera.h.s"

.include "gameOver.h.s"
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

gameOverCoin:
    .db #0

boolGameOverLoop:
    .db #0

gameOverCount:
    .db #9

gameOverSubCount:
    .dw #4000

softResetJump:
    .dw #0

gameOverTimer:
    .dw #20000

blinkGameOverTimer:
    .dw #0

boolGameOverBlink:
    .db #1


manGameOverInit::

    ld (softResetJump), hl

    ld a, #0
    ld (gameOverCoin), a

    ld a, #0
    ld (boolGameOverLoop), a

    ld a, #9
    ld (gameOverCount), a

    ld hl, #4000
    ld (gameOverSubCount), hl

    ld hl, #20000
    ld (#gameOverTimer), hl

    ld hl, #4000
    ld (#blinkGameOverTimer), hl

    ld a, #1
    ld (#boolGameOverBlink), a

    call sysGeneratorInitGameOver

    ld a, (#gameOverCount)
    call sysRenderGameOverCount

ret



manGameOverLoop::

    call manGameOverCheckInput
    call manGameOverUpdate
    call manGameOverCheckBlink

    ld a, (#boolGameOverLoop)
    or a
    
    jp z, manGameOverLoop

    ld a, #0
    ld (boolGameOverLoop), a

    call sysGeneratorInitGameOver2

manGameOverLoop2:

    call manGameOverCheckInput2

    ld hl, (#gameOverTimer)
    dec hl
    ld (gameOverTimer), hl

    ld a, h
    or a

    jp nz, skipGameOverTimer

    ld a, l
    or a

    jp nz, skipGameOverTimer

    ld a, #1
    ld (boolGameOverLoop), a

skipGameOverTimer:

    ld a, (#boolGameOverLoop)
    or a

    jp z, manGameOverLoop2

ret

manGameOverUpdate:

    ld hl, (#gameOverSubCount)
    dec hl
    ld (gameOverSubCount), hl

    ld a, h
    or a
    
    ret nz

    ld a, l
    or a

    ret nz

    ;; Reset gameOverSubCount

    ld hl, #4000
    ld (gameOverSubCount), hl

    ld a, (#gameOverCount)
    or a
    
    jp z, finishGameOver

    dec a
    ld (gameOverCount), a
    
    call sysRenderGameOverCount

    ret

    finishGameOver:

    ld a, #1
    ld (boolGameOverLoop), a

ret



manGameOverCheckInput:

    call cpct_scanKeyboard_asm

    ld hl, #Key_C
    call cpct_isKeyPressed_asm

    jr nz, cGameOverPulsada

    ret

cGameOverPulsada:

    ld a, (#gameOverCoin)
    dec a
    ld (gameOverCoin), a

    ld hl, (#softResetJump)
    jp (hl)

ret




manGameOverCheckInput2:

    call cpct_scanKeyboard_asm

    ld hl, #Key_P
    call cpct_isKeyPressed_asm

    jr nz, pGameOverPulsada

    ret

pGameOverPulsada:

    ld a, #1
    ld (boolGameOverLoop), a

ret



manGameOverCheckBlink:

    ld hl, (#blinkGameOverTimer)
    dec hl
    ld (blinkGameOverTimer), hl

    ld a, h
    or a

    ret nz

    ld a, l
    or a

    ret nz

    ld a, (#boolGameOverBlink)
    or a

    jp z, blinkGameOverDraw

    ld hl, #2000
    ld (blinkGameOverTimer), hl

    ld a, #0
    ld (boolGameOverBlink), a

    call sysGeneratorMenuErase

    ret

blinkGameOverDraw:

    ld hl, #4000
    ld (blinkGameOverTimer), hl


    ld a, #1
    ld (boolGameOverBlink), a

    ld a, (#gameOverCoin)
    or a

    jp z, blinkGameOverDrawInsert

    call sysGeneratorMenuSpace

    ret

blinkGameOverDrawInsert:

    call sysGeneratorMenuInsertCoin

ret